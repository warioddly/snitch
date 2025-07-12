
import 'package:snitch/src/levels/level.dart';

class LogRecord {

  final String message;
  final DateTime? time;
  final String name;
  final Object? error;
  final StackTrace? stackTrace;
  final Level level;

  LogRecord({
    required this.message,
    required this.time,
    required this.level,
    this.name = '',
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'LogRecord(message: $message, time: $time, name: $name, error: $error, stackTrace: $stackTrace)';
  }



}