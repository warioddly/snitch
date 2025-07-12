import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/utils/log_formatter.dart';

class ConsoleOutputAdapter implements OutputAdapter {

  ConsoleOutputAdapter._([ConsoleFormatter? formatter])
    : _formatter = formatter ?? ConsoleFormatter();

  static final ConsoleOutputAdapter _instance = ConsoleOutputAdapter._();

  factory ConsoleOutputAdapter() => _instance;

  final ConsoleFormatter _formatter;

  @override
  void log(LogRecord logRecord) {
    print(_formatter.format(logRecord));
  }
}
