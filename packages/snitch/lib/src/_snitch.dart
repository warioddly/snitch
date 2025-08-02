import 'dart:async';

import 'package:snitch/src/adapters/_output_adapter.dart';
import 'package:snitch/src/level.dart';
import 'package:snitch/src/log.dart';

abstract base class Snitch {
  factory Snitch({
    int maxLogs = 1000,
    List<OutputAdapter> adapters = const [],
    bool enabled = true,
  }) {
    assert(maxLogs > 0, 'maxLogs must be greater than 0.');
    assert(
      adapters.isNotEmpty,
      'No output adapters provided. '
      'Please provide at least one OutputAdapter to handle the logs.',
    );
    return _Snitch(
      enabled: enabled,
      maxLogs: maxLogs,
      adapters: List.unmodifiable(adapters),
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
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Logs a message with a specific type.
  void logWith<T extends OutputAdapter>(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  Stream<Log> stream();

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

  StreamController<Log>? _logStreamController;

  @override
  Stream<Log> stream() {
    if (_logStreamController != null) {
      return _logStreamController!.stream.asBroadcastStream();
    }

    closeStream();
    return (_logStreamController = StreamController<Log>.broadcast()).stream;
  }

  @override
  Future<void> closeStream() async {
    await _logStreamController?.close();
    _logStreamController = null;
  }

  @override
  void log(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    final log = _log(
      message,
      level: level,
      time: time,
      name: name,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );

    if (log == null) {
      return;
    }

    for (final adapter in adapters) {
      adapter.log(log);
    }
  }

  @override
  void logWith<T extends OutputAdapter>(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    final log = _log(
      message,
      level: level,
      time: time,
      name: name,
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );

    if (log == null) {
      return;
    }

    final adapters = this.adapters.whereType<T>();

    for (final adapter in adapters) {
      adapter.log(log);
    }
  }

  Log? _log(
    String message, {
    Level level = const DebugLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    if (!enabled) {
      print('Snitch is disabled. Log not recorded');
      return null;
    }

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

    if (!(_logStreamController?.isClosed ?? true)) {
      _logStreamController?.add(log);
    }

    return log;
  }
}
