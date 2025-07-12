import 'dart:io';

import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/levels/utils.dart';
import 'package:snitch/src/log_record.dart';

class FileOutputAdapter implements OutputAdapter {
  final String filePath;
  final IOSink _sink;

  final LevelFilter filter;

  FileOutputAdapter(this.filePath, {LevelFilter? filter})
    : filter = filter ?? levelFilter,
      _sink = File(filePath).openWrite(mode: FileMode.append);

  @override
  void log(LogRecord logRecord) {

    if (!filter.call(logRecord.level)) {
      return;
    }

    _sink.writeln(logRecord.toString());
  }

  Future<void> close() async {
    await _sink.flush();
    await _sink.close();
  }
}
