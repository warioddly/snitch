import 'package:snitch/src/log.dart';
import 'package:snitch/src/patterns.dart';
import 'package:snitch/src/level.dart';

/// Super class for output formatters.
class LogFormatter {
  const LogFormatter([this._patterns]);

  final Map<Type, String>? _patterns;

  String format(Log log) => log.toString();

  String resolvePattern(Level level) {
    return _patterns?[level.runtimeType] ?? _patterns?[Level] ?? defaultPattern;
  }
}
