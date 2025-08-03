import 'dart:async';

import 'package:snitch/snitch.dart' show OutputAdapter;
import 'package:snitch/src/formatters/_log_formatter.dart';
import 'package:snitch/src/formatters/console_log_formatter.dart';
import 'package:snitch/src/log.dart';

class ConsoleAdapter extends OutputAdapter {
  ConsoleAdapter({LogFormatter? formatter, super.filter})
    : super(formatter: formatter ?? ConsoleLogFormatter());

  @override
  void log(Log log) {
    if (!filter.call(log.level)) {
      return;
    }

    Zone.root.print(formatter.format(log));
  }
}
