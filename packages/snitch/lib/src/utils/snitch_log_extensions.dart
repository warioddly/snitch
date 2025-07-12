import 'package:snitch/snitch.dart';

extension SnitchLoggerExtension on Snitch {
  void e(
    String message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) => log(
    message,
    time: time,
    name: 'ERROR',
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
    time: time,
    name: 'WARNING',
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
    time: time,
    name: 'INFO',
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
    time: time,
    name: 'DEBUG',
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
    time: time,
    name: 'TRACE',
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
    time: time,
    name: 'VERBOSE',
    error: error,
    stackTrace: stackTrace,
    metadata: metadata,
  );
}
