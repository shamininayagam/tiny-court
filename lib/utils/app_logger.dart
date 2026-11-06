import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

class _AppPrinter extends PrettyPrinter {
  _AppPrinter()
      : super(
          stackTraceBeginIndex: 1,
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 80,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
          excludeBox: const <Level, bool>{},
          noBoxingByDefault: true,
        ) {
    PrettyPrinter.defaultLevelEmojis[Level.trace] = '🔊 ';
  }

  @override
  String getTime(DateTime time) {
    return '${time.day}/${time.month}/${time.year} ${super.getTime(time)}';
  }

  @override
  String stringifyMessage(event) {
    final String seperator = '=' * 70;
    return <String>[seperator, super.stringifyMessage(event), seperator]
        .join('\n');
  }
}

class _AppOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(debugPrint);
  }
}

abstract class AppLogger {
  final Logger _log = Logger(
    printer: _AppPrinter(),
    output: _AppOutput(),
  );

  void error(Object error, [StackTrace? s]) {
    e('''
Error: $error

Stacktrace: $s
''');
  }

  void startMethod() {
    final String? member = Trace.current().frames[1].member;
    v('Method Start -> $member');
  }

  void endMethod() {
    final String? member = Trace.current().frames[1].member;
    v('Method End -> $member');
  }

  void d(dynamic message) => _log.d(message);

  void i(dynamic message) => _log.i(message);

  void e(dynamic message) => _log.e(message);

  void v(dynamic message) => _log.t(message);

  void w(dynamic message) => _log.w(message);
}

class _AppLogger extends AppLogger {
  static final _AppLogger _logger = _AppLogger();
}

extension LoggerUtils on Object {
  AppLogger get log => _AppLogger._logger;
}
