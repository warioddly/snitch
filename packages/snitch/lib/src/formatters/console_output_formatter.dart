import 'package:snitch/src/formatters/_format_patterns.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/utils/ansi_colors.dart';

typedef DateTimeFormatter = String Function(DateTime);

String _defaultTimeFormatter(DateTime time) => time.toIso8601String();

class ConsoleOutputFormatter extends OutputFormatter {
  ConsoleOutputFormatter({
    Map<Type, String>? patterns = defaultConsolePatterns,
    DateTimeFormatter? timeFormatter,
  }) : timeFormatter = timeFormatter ?? _defaultTimeFormatter,
       super(patterns);

  final DateTimeFormatter timeFormatter;
  static final _buffer = StringBuffer();

  @override
  String format(LogRecord logRecord) {
    _buffer.clear();

    final pattern = resolvePattern(logRecord.level);

    String output = pattern
        .replaceAll('{level}', logRecord.level.name)
        .replaceAll('{time}', timeFormatter(logRecord.time))
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
