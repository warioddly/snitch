import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/utils/ansi_colors.dart';

class ConsoleOutputAdapter implements OutputAdapter {
  /// Singleton instance of ConsoleOutputAdapter.
  const ConsoleOutputAdapter._();

  static const instance = ConsoleOutputAdapter._();

  factory ConsoleOutputAdapter() => instance;

  static final _buffer = StringBuffer();

  @override
  void log(LogRecord logRecord) {

    _buffer
      ..clear()
      ..write(AnsiColors.colorize('[${logRecord.name}] ', AnsiColors.red))
      ..write(
        AnsiColors.colorize(
          '[${logRecord.time?.toIso8601String()}]',
          AnsiColors.brightBlack,
        ),
      )
      ..write(' ')
      ..write(AnsiColors.colorize(logRecord.message, AnsiColors.green));

    if (logRecord.stackTrace != null) {
      _buffer
        ..writeln('')
        ..writeln(AnsiColors.colorize('------------------STACK TRACE------------------', AnsiColors.red))
        ..writeln(AnsiColors.colorize(logRecord.stackTrace.toString(), AnsiColors.yellow))
        ..writeln(AnsiColors.colorize('-----------------------------------------------', AnsiColors.red));
    }

    print(_buffer.toString());
  }
}
