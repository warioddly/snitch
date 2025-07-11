

class LogRecord {
  final String message;
  final DateTime timestamp;
  final String? level;

  LogRecord({
    required this.message,
    required this.timestamp,
    this.level,
  });

  @override
  String toString() {
    return '[$timestamp] ${level != null ? '[$level] ' : ''}$message';
  }
}