import 'dart:async';

import 'package:snitch/src/output_adapter.dart';
import 'package:snitch/src/level.dart';
import 'package:snitch/src/log.dart';

abstract base class Snitch {
  factory Snitch({
    int maxLogs = 1000,
    List<OutputAdapter> adapters = const [],
    bool enabled = true,
  }) {
    assert(maxLogs > 0, 'maxLogs must be greater than 0.');
    // assert(
    //   adapters.isNotEmpty,
    //   'No output adapters provided. '
    //   'Please provide at least one OutputAdapter to handle the logs.',
    // );
    return _Snitch(
      enabled: enabled,
      maxLogs: maxLogs,
      adapters: adapters,
    );
  }

  /// Whether the Snitch is enabled.
  bool get enabled;

  /// Maximum number of logs to keep in memory.
  int get maxLogs;

  /// Log records are stored in memory.
  List<Log> get logs;

  /// Output adapters to handle the logs.
  List<OutputAdapter> get adapters;

  /// Logs a message with optional parameters.
  void log(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Logs a message with a specific type.
  void logWith<T extends OutputAdapter>(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  Stream<Log> get stream;

  Future<void> closeStream();
}

final class _Snitch implements Snitch {
  _Snitch({
    required this.enabled,
    required this.maxLogs,
    required this.adapters,
  });

  @override
  final bool enabled;

  @override
  final int maxLogs;

  @override
  final List<OutputAdapter> adapters;

  final List<Log> _logs = [];

  @override
  List<Log> get logs => List.unmodifiable(_logs);

  final _streamController = StreamController<Log>.broadcast();

  @override
  Stream<Log> get stream => _streamController.stream.asBroadcastStream();

  @override
  Future<void> closeStream() => _streamController.close();

  @override
  void log(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    if (!enabled) {
      print('Snitch is disabled. Log not recorded');
      return;
    }

    final log = _log(
      message,
      level: level,
      time: time,
      name: name,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );

    for (final adapter in adapters) {
      adapter.log(log);
    }
  }

  @override
  void logWith<T extends OutputAdapter>(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    if (!enabled) {
      print('Snitch is disabled. Log not recorded');
      return;
    }

    final log = _log(
      message,
      level: level,
      time: time,
      name: name,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );

    final adapters = this.adapters.whereType<T>();

    for (final adapter in adapters) {
      adapter.log(log);
    }
  }

  Log _log(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String? name,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    if (_logs.length >= maxLogs) {
      _logs.removeAt(0);
    }

    final log = Log(
      message: message,
      time: time ?? DateTime.now(),
      name: name,
      error: error,
      stackTrace: stackTrace,
      level: level,
      metadata: metadata,
    );

    _logs.add(log);

    if (!_streamController.isClosed) {
      _streamController.add(log);
    }

    return log;
  }
}
