import 'package:snitch/src/formatters/_log_formatter.dart';
import 'package:snitch/src/level.dart';
import 'package:snitch/src/log.dart';

typedef LevelFilter = bool Function(Level level);

bool _levelFilter(Level _) => true;

/// Abstract class for output adapters.
abstract class OutputAdapter {
  OutputAdapter({LogFormatter? formatter, LevelFilter? filter})
    : formatter = formatter ?? LogFormatter(),
      filter = filter ?? _levelFilter;

  final LogFormatter formatter;
  final LevelFilter filter;

  void log(Log logRecord);
}
