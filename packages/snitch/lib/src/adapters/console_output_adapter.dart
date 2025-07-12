import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/log_record.dart';
import 'package:snitch/src/formatters/_output_formatter.dart';
import 'package:snitch/src/formatters/console_output_formatter.dart';

class ConsoleOutputAdapter extends OutputAdapter {
  ConsoleOutputAdapter({OutputFormatter? formatter, super.filter})
    : super(formatter: formatter ?? ConsoleOutputFormatter());

  @override
  void log(LogRecord logRecord) {
    if (!filter.call(logRecord.level)) {
      return;
    }

    print(formatter.format(logRecord));
  }
}
