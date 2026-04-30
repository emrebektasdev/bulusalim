import 'package:firebase_analytics/firebase_analytics.dart';
import '../firebase/app_logger.dart';

/// Thin wrapper around [FirebaseAnalytics].
///
/// Currently just exposes the instance and the [observer] for GoRouter.
/// Event logging methods will be added here as features are built —
/// never call [FirebaseAnalytics.instance] directly outside this class.
class AnalyticsService {
  AnalyticsService._();

  static final _log = AppLogger.getLogger('AnalyticsService');
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  static Future<void> init() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
    _log.info('Analytics initialised');
  }

  /// Log a named event with optional parameters.
  static Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      _log.warning('Analytics logEvent failed: $name', e);
    }
  }
}
