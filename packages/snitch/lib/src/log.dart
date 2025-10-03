import 'package:snitch/src/level.dart';

final class Log {
  final String message;
  final DateTime time;
  final String? name;
  final Object? error;
  final StackTrace? stackTrace;
  final Level level;
  final Map<String, dynamic>? metadata;

  const Log({
    required this.message,
    required this.time,
    required this.level,
    this.name,
    this.error,
    this.stackTrace,
    this.metadata,
  });

  @override
  String toString() {
    final buffer = StringBuffer();

    if (name != null) {
      buffer.write('[$name] ');
    }

    buffer
      ..write('[${level.name}] ')
      ..write('[$time] ')
      ..write(message);

    if (error != null) {
      buffer.write(' Error: $error');
    }

    if (stackTrace != null) {
      buffer.write('\nStack Trace:\n$stackTrace');
    }

    return buffer.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'time': time.toIso8601String(),
      'stackTrace': stackTrace,
      'level': level.toJson(),
      'metadata': metadata,
    };
  }
}
