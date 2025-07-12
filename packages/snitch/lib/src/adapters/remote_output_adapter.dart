import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';

class FileOutputAdapter implements OutputAdapter {
  final String filePath;

  FileOutputAdapter(this.filePath);

  @override
  void log(LogRecord logRecord) {
    print('Writing to $filePath');
  }
}
