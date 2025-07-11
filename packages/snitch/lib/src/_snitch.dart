import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/output_adapter.dart';

abstract class Snitch {

  factory Snitch({
    int maxLogs = 1000,
    adapters = const <OutputAdapter>[ ConsoleOutputAdapter() ],
  }) => _Snitch(
    maxLogs: maxLogs,
    adapters: adapters,
  );

  List<LogRecord> get logs;

  List<OutputAdapter> get adapters;

  void log(
    String message, {
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
  });
}

class _Snitch implements Snitch {

  _Snitch({
    required this.maxLogs,
    required List<OutputAdapter> adapters,
  }) : _adapters = List.unmodifiable(adapters);

  final int maxLogs;


  final List<OutputAdapter> _adapters;

  @override
  List<OutputAdapter> get adapters => List.unmodifiable(_adapters);


  final List<LogRecord> _logs = [];

  @override
  List<LogRecord> get logs => List.unmodifiable(_logs);


  @override
  void log(
    String message, {
    DateTime? time,
    String name = '',
    Object? error,
    StackTrace? stackTrace,
  }) {

    final log = LogRecord(
      message: message,
      timestamp: time ?? DateTime.now(),
      level: name.isNotEmpty ? name : null,
    );

    if (_logs.length >= maxLogs) {
      _logs.removeAt(0);
    }

    _logs.add(log);

    for (final adapter in _adapters) {
      adapter.log(log);
    }

  }
}
