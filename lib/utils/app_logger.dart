import 'package:flutter/foundation.dart';

/// Central logging facade matching the pogo_alarm architecture.
///
/// Obtain one instance per class through the static [get] factory and store
/// it in a `_log` field:
/// ```dart
/// static final AppLogger _log = AppLogger.get('CaseDraftMixin');
/// ```
base class AppLogger {
  /// Tag prefix printed with every message — conventionally the class or mixin name.
  final String _tag;

  /// Private constructor; create loggers via the [get] factory.
  const AppLogger._(this._tag);

  /// Returns a logger tagged with [tag], conventionally the class or mixin name.
  static AppLogger get(String tag) => AppLogger._(tag);

  /// Verbose-level message; only emitted in debug builds.
  void verbose(String message) => _log('VERBOSE', message);

  /// Debug-level message; only emitted in debug builds.
  void debug(String message) => _log('DEBUG', message);

  /// Informational message, emitted in all builds.
  void info(String message) => _log('INFO', message);

  /// Warning message, emitted in all builds.
  void warning(String message) => _log('WARNING', message);

  /// Error message with the accompanying [error]; emitted in all builds.
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log('ERROR', message);
    if (error != null) {
      debugPrint('[$_tag] ERROR details: $error');
    }
    if (stackTrace != null) {
      debugPrint('[$_tag] ERROR stack:\n$stackTrace');
    }
  }

  /// Fatal message with the accompanying [error]; emitted in all builds.
  void fatal(String message, {Object? error, StackTrace? stackTrace}) {
    _log('FATAL', message);
    if (error != null) {
      debugPrint('[$_tag] FATAL details: $error');
    }
    if (stackTrace != null) {
      debugPrint('[$_tag] FATAL stack:\n$stackTrace');
    }
  }

  void _log(String level, String message) {
    if (!kDebugMode && (level == 'VERBOSE' || level == 'DEBUG')) {
      return;
    }
    debugPrint('[$_tag] $level: $message');
  }

  // ── Backward-compatibility with legacy logger calls ────────────────────────
  void d(dynamic message) => debug('$message');
  void i(dynamic message) => info('$message');
  void e(dynamic message) => error('$message');
  void v(dynamic message) => verbose('$message');
  void w(dynamic message) => warning('$message');
}

final class _AppLogger extends AppLogger {
  _AppLogger() : super._('App');
  static final _AppLogger _logger = _AppLogger();
}

extension LoggerUtils on Object {
  AppLogger get log => _AppLogger._logger;
}
