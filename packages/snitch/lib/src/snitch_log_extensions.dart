import 'package:snitch/snitch.dart';

extension SnitchLoggerExtension on Snitch {
  void e(String message) {
    log('Error: $message');
  }

  void w(String message) {
    log('Warning: $message');
  }

  void i(String message) {
    log('Info: $message');
  }

  void d(String message) {
    log('Debug: $message');
  }

  void t(String message) {
    log('Trace: $message');
  }

  void v(String message) {
    log('Verbose: $message');
  }
}
