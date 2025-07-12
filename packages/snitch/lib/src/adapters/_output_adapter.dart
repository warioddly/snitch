import 'package:snitch/src/log_record.dart';

/// Abstract class for output adapters.
abstract class OutputAdapter {

  const OutputAdapter();

  void log(LogRecord logRecord);
}