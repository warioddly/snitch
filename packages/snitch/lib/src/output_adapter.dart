

import 'package:snitch/src/log_record.dart';

abstract class OutputAdapter {

  const OutputAdapter();

  void log(LogRecord logRecord);
}

class ConsoleOutputAdapter implements OutputAdapter {

  const ConsoleOutputAdapter();

  @override
  void log(LogRecord logRecord) {
    print(logRecord.toString());
  }
}

class FileOutputAdapter implements OutputAdapter {
  final String filePath;

  FileOutputAdapter(this.filePath);

  @override
  void log(LogRecord logRecord) {
    print('Writing to $filePath');
  }
}

class RemoteOutputAdapter implements OutputAdapter {
  final String endpoint;

  RemoteOutputAdapter(this.endpoint);

  @override
  void log(LogRecord logRecord) {
    print('Sending to $endpoint');
  }
}