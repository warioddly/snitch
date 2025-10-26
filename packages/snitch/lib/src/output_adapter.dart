import 'package:snitch_interface/snitch_interface.dart';

/// Abstract class for output adapters.
abstract class OutputAdapter {
  const OutputAdapter();

  void log(Log record);
}
