import 'dart:async';

import 'package:snitch/src/adapters/_output_adapter.dart';
import 'package:snitch/src/levels/level.dart';
import 'package:snitch/src/log_record.dart';

abstract class Snitch {
  factory Snitch({
    int maxLogs = 1000,
    List<OutputAdapter> adapters = const [],
  }) {
    assert(maxLogs > 0, 'maxLogs must be greater than 0.');
    assert(
      adapters.isNotEmpty,
      'No output adapters provided. '
      'Please provide at least one OutputAdapter to handle the logs.',
    );
    return _Snitch(maxLogs: maxLogs, adapters: List.unmodifiable(adapters));
  }

  /// Log records are stored in memory.
  List<LogRecord> get logs;

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

  Stream<LogRecord> stream();

  Future<void> closeStream();
}

class _Snitch implements Snitch {
  _Snitch({required this.maxLogs, required this.adapters});

  /// Maximum number of logs to keep in memory.
  final int maxLogs;

  @override
  final List<OutputAdapter> adapters;

  final List<LogRecord> _logs = [];

  @override
  List<LogRecord> get logs => List.unmodifiable(_logs);

  StreamController<LogRecord>? _logStreamController;

  @override
  Stream<LogRecord> stream() {
    if (_logStreamController != null) {
      return _logStreamController!.stream.asBroadcastStream();
    }

    closeStream();
    return (_logStreamController = StreamController<LogRecord>.broadcast())
        .stream;
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
    try {

      if (_logs.length >= maxLogs) {
        _logs.removeAt(0);
      }

      final log = LogRecord(
        message: message,
        time: time ?? DateTime.now(),
        name: name,
        error: error,
        stackTrace: stackTrace,
        level: level,
      );

      _logs.add(log);

      if (!(_logStreamController?.isClosed ?? true)) {
        _logStreamController?.add(log);
      }

      for (final adapter in adapters) {
        adapter.log(log);
      }
    } catch (error, stacktrace) {
      print('$error $stacktrace');
    }
  }
}
