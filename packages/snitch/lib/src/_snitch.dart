import 'dart:async';

import 'package:snitch/src/adapters/_output_adapter.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/levels/level.dart';
import 'package:snitch/src/log_record.dart';

abstract class Snitch {
  factory Snitch({
    int maxLogs = 1000,
    adapters = const <OutputAdapter>[ConsoleOutputAdapter.instance],
  }) => _Snitch(maxLogs: maxLogs, adapters: adapters);

  /// Log records are stored in memory.
  List<LogRecord> get logs;

  /// Output adapters to handle the logs.
  List<OutputAdapter> get adapters;

  /// Logs a message with optional parameters.
  void log(
    String message, {
    Level level = const InfoLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  Stream<LogRecord> stream();

  void closeStream();

}

class _Snitch implements Snitch {
  _Snitch({required this.maxLogs, required List<OutputAdapter> adapters})
    : _adapters = List.unmodifiable(adapters),
      assert(
        adapters.isNotEmpty,
        'No output adapters provided. '
        'Please provide at least one OutputAdapter to handle the logs.',
      ),
      assert(maxLogs > 0, 'maxLogs must be greater than 0.');

  /// Maximum number of logs to keep in memory.
  final int maxLogs;

  final List<OutputAdapter> _adapters;

  @override
  List<OutputAdapter> get adapters => List.unmodifiable(_adapters);

  final List<LogRecord> _logs = [];

  @override
  List<LogRecord> get logs => List.unmodifiable(_logs);


  StreamController? _logStreamController;

  @override
  Stream<LogRecord> stream() {
    closeStream();
    return (_logStreamController = StreamController<LogRecord>.broadcast()).stream;
  }

  @override
  void closeStream() {
    _logStreamController?.close();
    _logStreamController = null;
  }

  @override
  void log(
    String message, {
    Level level = const InfoLevel(),
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    try {
      final log = LogRecord(
        message: message,
        time: time ?? DateTime.now(),
        name: name,
        error: error,
        stackTrace: stackTrace,
        level: level,
      );

      if (_logs.length >= maxLogs) {
        _logs.removeAt(0);
      }

      _logs.add(log);

      if (!(_logStreamController?.isClosed ?? true)) {
        _logStreamController?.add(log);
      }

      for (final adapter in _adapters) {
        adapter.log(log);
      }
    }
    catch (error, stacktrace) {
      print('$error $stacktrace');
    }

  }
}
