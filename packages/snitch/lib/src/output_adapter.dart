import 'package:snitch/src/log.dart';

/// Abstract class for output adapters.
abstract class OutputAdapter {
  const OutputAdapter();

  void log(Log record);
}
