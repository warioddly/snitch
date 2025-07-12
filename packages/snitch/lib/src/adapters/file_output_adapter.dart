import 'dart:io';

import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';
import 'package:snitch/src/formatters/file_output_formatter.dart';

class FileOutputAdapter extends OutputAdapter {
  final String filePath;
  final IOSink _sink;

  FileOutputAdapter(this.filePath, {super.filter, OutputFormatter? formatter})
    : _sink = File(filePath).openWrite(mode: FileMode.append),
      super(formatter: formatter ?? FileOutputFormatter());

  @override
  void log(LogRecord logRecord) {
    if (!filter.call(logRecord.level)) {
      return;
    }

    _sink.writeln(formatter.format(logRecord));
  }

  Future<void> close() async {
    await _sink.flush();
    await _sink.close();
  }
}
