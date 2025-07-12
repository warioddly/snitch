import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';
import 'dart:io';

class FileOutputAdapter implements OutputAdapter {
  final String filePath;
  final IOSink _sink;

  FileOutputAdapter(this.filePath) : _sink = File(filePath).openWrite(mode: FileMode.append);

  @override
  void log(LogRecord logRecord) {
    _sink.writeln(logRecord.toString());
  }

  Future<void> close() async {
    await _sink.flush();
    await _sink.close();
  }
}