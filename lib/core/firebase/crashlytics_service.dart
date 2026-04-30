import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import '../firebase/app_logger.dart';

/// Wires [FirebaseCrashlytics] into Flutter and Dart error zones.
///
/// Call [CrashlyticsService.init] once from [main] AFTER [Firebase.initializeApp].
class CrashlyticsService {
  CrashlyticsService._();

  static final _log = AppLogger.getLogger('CrashlyticsService');

  static Future<void> init() async {
    // Disable collection on debug builds so developer errors are not reported.
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);

    // Catch Flutter framework errors.
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    // Catch async errors outside of Flutter (e.g. Isolate errors).
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Catch isolate errors on non-web platforms.
    if (!kIsWeb) {
      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair as List<dynamic>;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          StackTrace.fromString(errorAndStacktrace.last as String),
          fatal: true,
        );
      }).sendPort);
    }

    _log.info('Crashlytics initialised (enabled: ${!kDebugMode})');
  }

  /// Record a non-fatal error — use in catch blocks where the app can recover.
  static Future<void> recordError(Object error, StackTrace stack, {String? reason}) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      reason: reason,
      fatal: false,
    );
  }
}
