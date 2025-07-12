import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';
import 'package:snitch/src/levels/filter.dart';

/// Abstract class for output adapters.
abstract class OutputAdapter {
  OutputAdapter({OutputFormatter? formatter, LevelFilter? filter})
    : formatter = formatter ?? OutputFormatter(),
      filter = filter ?? levelFilter;

  final OutputFormatter formatter;
  final LevelFilter filter;

  void log(LogRecord logRecord);
}
