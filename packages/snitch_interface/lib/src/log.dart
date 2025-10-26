import 'level.dart';

final class Log {

  final String message;
  final int timestamp;
  final Level level;
  final String? name;
  final Object? error;
  final StackTrace? stackTrace;
  final Map<String, dynamic>? metadata;

  const Log({
    required this.message,
    required this.timestamp,
    required this.level,
    this.name,
    this.error,
    this.stackTrace,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'timestamp': timestamp,
      'stackTrace': stackTrace,
      'level': level.toJson(),
      'metadata': metadata,
    };
  }
}
