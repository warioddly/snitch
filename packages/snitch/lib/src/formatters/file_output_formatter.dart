import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';

class FileOutputFormatter extends OutputFormatter {
  FileOutputFormatter({Map<Type, String>? patterns}) : super(patterns);

  static final _buffer = StringBuffer();

  @override
  String format(LogRecord logRecord) {
    _buffer.clear();

    final pattern = resolvePattern(logRecord.level);

    String output = pattern
        .replaceAll('{level}', logRecord.level.name)
        .replaceAll('{time}', logRecord.time.toIso8601String())
        .replaceAll('{message}', logRecord.message);

    _buffer.write(output);

    if (logRecord.stackTrace != null) {
      _buffer
        ..writeln('')
        ..writeln('------------------STACK TRACE------------------')
        ..writeln(logRecord.stackTrace)
        ..writeln('-----------------------------------------------');
    }

    return _buffer.toString();
  }
}
