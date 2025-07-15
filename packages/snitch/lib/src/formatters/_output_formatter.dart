import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_patterns.dart';
import 'package:snitch/src/levels/level.dart';

/// Super class for output formatters.
class OutputFormatter {
  const OutputFormatter([this._patterns]);

  final Map<Type, String>? _patterns;

  String format(LogRecord logRecord) => logRecord.toString();

  String resolvePattern(Level level) {
    return _patterns?[level.runtimeType] ?? _patterns?[Level] ?? defaultPattern;
  }
}
