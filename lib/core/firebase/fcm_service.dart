import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../firebase/app_logger.dart';

/// Top-level handler required by FCM for background/terminated state messages.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final log = AppLogger.getLogger('FCM.Background');
  log.info('Background message: ${message.messageId}');
}

/// Bootstraps FCM and local notifications.
/// Call [FcmService.init] once from [main] AFTER [Firebase.initializeApp].
class FcmService {
  FcmService._();

  static final _log = AppLogger.getLogger('FcmService');
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static const _channelId = 'bulusalim_default';
  static const _channelName = 'Buluşalım Bildirimleri';
  static const _channelDescription = 'Etkinlik ve topluluk bildirimleri';

  static Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await _initLocalNotifications();
    await _requestPermission();
    _listenForeground();
  }

  static Future<void> _initLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (_) {},
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDescription,
            importance: Importance.high,
          ),
        );
  }

  static Future<void> _requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    _log.info('FCM permission: ${settings.authorizationStatus}');
  }

  static void _listenForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
      );
    });
  }

  /// Returns the device FCM token. Store under users/{uid}/fcmToken on login.
  static Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      _log.warning('Could not get FCM token', e);
      return null;
    }
  }
}
