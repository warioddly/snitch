import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/utils/ansi_colors.dart';
import 'package:snitch/src/formatters/_format_patterns.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';

class ConsoleOutputFormatter extends OutputFormatter {
  ConsoleOutputFormatter({Map<Type, String>? patterns = defaultConsolePatterns})
    : super(patterns);

  static final _buffer = StringBuffer();

  @override
  String format(LogRecord logRecord) {
    _buffer.clear();

    final pattern = resolvePattern(logRecord.level);

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
