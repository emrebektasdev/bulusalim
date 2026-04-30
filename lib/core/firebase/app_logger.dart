import 'package:logging/logging.dart';

/// App-scoped logger factory.
///
/// Usage:
/// ```dart
/// final _log = AppLogger.getLogger('AuthRepository');
/// _log.warning('Login failed', error, stack);
/// ```
abstract final class AppLogger {
  static Logger getLogger(String name) => Logger(name);

  /// Call once during app startup (in [main]) to configure log output.
  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('[${record.level.name}] ${record.loggerName}: ${record.message}'
          '${record.error != null ? '\n${record.error}' : ''}'
          '${record.stackTrace != null ? '\n${record.stackTrace}' : ''}');
    });
  }
}
