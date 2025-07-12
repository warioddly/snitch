import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/levels/utils.dart';
import 'package:snitch/src/log_record.dart';


class RemoteOutputAdapter implements OutputAdapter {

  final LevelFilter filter;

  RemoteOutputAdapter({
    LevelFilter? filter
  }) : filter = filter ?? levelFilter;

  @override
  void log(LogRecord logRecord) {

    if (!filter.call(logRecord.level)) {
      return;
    }

    print('REMOTE OUTPUT: ${logRecord.toString()}');

  }
}
