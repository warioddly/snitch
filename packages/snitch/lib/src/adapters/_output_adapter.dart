import 'package:snitch/src/levels/_levels.dart';
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';

bool _levelFilter(Level level) => true;

/// Abstract class for output adapters.
abstract class OutputAdapter {
  OutputAdapter({OutputFormatter? formatter, LevelFilter? filter})
    : formatter = formatter ?? OutputFormatter(),
      filter = filter ?? _levelFilter;

  final OutputFormatter formatter;
  final LevelFilter filter;

  void log(LogRecord logRecord);
}
