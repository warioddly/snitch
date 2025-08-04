import 'package:snitch/src/formatters/_log_formatter.dart';
import 'package:snitch/src/patterns.dart';
import 'package:snitch/src/log.dart';
import 'package:snitch/src/ansi_colors.dart';

typedef TimeFormatter = String Function(DateTime);

String _defaultTimeFormatter(DateTime time) => time.toIso8601String();

final class ConsoleLogFormatter extends LogFormatter {
  ConsoleLogFormatter({
    Map<Type, String> patterns = defaultConsolePatterns,
    TimeFormatter? timeFormatter,
  }) : timeFormatter = timeFormatter ?? _defaultTimeFormatter,
       super(patterns);

  final TimeFormatter timeFormatter;

  static final _buffer = StringBuffer();

  @override
  String format(Log log) {
    _buffer.clear();

    String output = resolvePattern(log.level)
        .replaceAll('{name}', log.name.isEmpty ? log.level.name : log.name)
        .replaceAll('{time}', timeFormatter(log.time))
        .replaceAll('{message}', log.message);

    _buffer.write(output);

    if (log.stackTrace != null) {
      _buffer
        ..writeln('')
        ..writeln(
          AnsiColors.colorize(
            '------------------STACK TRACE------------------',
            AnsiColors.red,
          ),
        )
        ..writeln(AnsiColors.colorize(log.stackTrace, AnsiColors.yellow))
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
