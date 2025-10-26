import 'package:snitch/snitch.dart';

extension SnitchLoggerExtension on Snitch {
  void e(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const ErrorLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  void w(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const WarningLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  void i(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const InfoLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  void d(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const DebugLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  void t(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const TraceLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );

  void v(
    String message, {
    int? timestamp,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) =>
      log(
        message,
        level: const VerboseLevel(),
        timestamp: timestamp,
        error: error,
        stackTrace: stackTrace,
        metadata: metadata,
      );
}
