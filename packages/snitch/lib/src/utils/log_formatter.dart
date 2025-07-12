import 'package:snitch/src/levels/level.dart';
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/utils/ansi_colors.dart';

final defaultPatterns = {
  ErrorLevel:
      '${AnsiColors.red}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.red}{message}${AnsiColors.reset}',
  WarningLevel:
      '${AnsiColors.yellow}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.yellow}{message}${AnsiColors.reset}',
  InfoLevel:
      '${AnsiColors.blue}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.blue}{message}${AnsiColors.reset}',
  DebugLevel:
      '${AnsiColors.blue}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}',
  TraceLevel:
      '${AnsiColors.brightBlack}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}',
  VerboseLevel:
      '${AnsiColors.brightWhite}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}',
};

final defaultPattern =
    '${AnsiColors.white}[{level}] ${AnsiColors.brightBlack}[{time}] - ${AnsiColors.green}{message}${AnsiColors.reset}';

abstract class LogFormatter {
  String format(LogRecord logRecord);
}

class ConsoleFormatter implements LogFormatter {
  ConsoleFormatter({Map<Type, String>? patterns})
    : patterns = patterns ?? defaultPatterns;

  final Map<Type, String> patterns;

  static final _buffer = StringBuffer();

  @override
  String format(LogRecord logRecord) {
    _buffer.clear();

    final pattern = patterns[logRecord.level.runtimeType] ?? defaultPattern;

    String output = pattern
        .replaceAll('{level}', logRecord.level.name)
        .replaceAll('{time}', logRecord.time?.toIso8601String() ?? '')
        .replaceAll('{message}', logRecord.message);

    _buffer.write(output);

    if (logRecord.stackTrace != null) {
      _buffer
        ..writeln('')
        ..writeln(
          AnsiColors.colorize(
            '------------------STACK TRACE------------------',
            AnsiColors.red,
          ),
        )
        ..writeln(
          AnsiColors.colorize(
            logRecord.stackTrace.toString(),
            AnsiColors.yellow,
          ),
        )
        ..writeln(
          AnsiColors.colorize(
            '-----------------------------------------------',
            AnsiColors.red,
          ),
        );
    }

    return _buffer.toString();
  }
}
