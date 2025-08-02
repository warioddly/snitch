import 'package:snitch/snitch.dart';
import 'package:snitch/src/level.dart';

extension SnitchLoggerExtension on Snitch {
  void e(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const ErrorLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );

  void w(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const WarningLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );

  void i(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const InfoLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );

  void d(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const DebugLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );

  void t(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const TraceLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );

  void v(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    level: const VerboseLevel(),
    time: time,
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );
}
