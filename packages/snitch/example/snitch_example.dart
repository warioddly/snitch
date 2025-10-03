import 'dart:async';

import 'package:snitch/snitch.dart';

Future<void> delay() => Future.delayed(Duration(milliseconds: 500));

class FatalLevel extends Level {
  const FatalLevel() : super(level: 101, name: 'FATAL');
}

extension on Snitch {
  void f(String message) => log(message, level: const FatalLevel());
}

void main() async {

  final snitch = Snitch(
    maxLogs: 50,
    adapters: [ConsoleAdapter()]
  );

  final subscription = snitch.stream.listen(
    (log) => print('Stream event: $log'),
    onDone: () => print('Stream closed'),
  );

  await runZonedGuarded(
    () async {
      snitch.log('message', name: 'NOT DEBUG');
      snitch.logWith<ConsoleAdapter>('awdawd');

      snitch
        ..t('Trace message')
        ..d('Debug message')
        ..i('Info message')
        ..w('Warning message')
        ..e('Error message', stackTrace: StackTrace.current)
        ..f('Fatal message');

      await delay();

      await snitch.closeStream();
      await subscription.cancel();

      await delay();

      print('This print is captured by Snitch too!');

      await delay();

      print('Done. Logs stored: ${snitch.logs.length}');
    },
    (error, stackTrace) {
      snitch.e('Unhandled error:', error: error, stackTrace: stackTrace);
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        snitch.i(line);
      },
    ),
  );
}

class ConsoleAdapter extends OutputAdapter {
  ConsoleAdapter();

  @override
  void log(Log record) {
    // if (!filter.call(log.level)) {
    //   return;
    // }
    Zone.root.print(record.message);
  }
}
