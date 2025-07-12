import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';

class RemoteOutputAdapter extends OutputAdapter {
  RemoteOutputAdapter({super.filter, super.formatter});

  @override
  void log(LogRecord logRecord) {
    if (!filter.call(logRecord.level)) {
      return;
    }

    print('REMOTE OUTPUT: ${logRecord.toString()}');
  }
}
