import 'package:snitch/snitch.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/adapters/file_output_adapter.dart';
import 'package:snitch/src/adapters/remote_output_adapter.dart';
import 'package:snitch/src/formatters/console_output_formatter.dart';
import 'package:snitch/src/levels/level.dart';


void main() async {
  final fileOutputAdapter = FileOutputAdapter(
    "logs.txt",
    filter: (Level level) => level.level == ErrorLevel.value,
  );

  final remoteOutputAdapter = RemoteOutputAdapter(
    filter: (Level level) =>
        level.level >= VerboseLevel.value && level.level <= WarningLevel.value,
  );

  var snitch = Snitch(
    maxLogs: 20,
    adapters: <OutputAdapter>[
      ConsoleOutputAdapter(
        formatter: ConsoleOutputFormatter(
          // patterns: {
          //   ErrorLevel: '${AnsiColors.brightRed}{level} [{message}]${AnsiColors.reset}'
          // },
        ),
      ),
      // fileOutputAdapter,
      // remoteOutputAdapter,
    ],
  );

  snitch
    ..t("message")
    ..i("info")
    ..w("warning")
    ..e("error")
    ..d("debug")
    ..v("verbose");

  var subscription = snitch.stream().listen(
    (data) => print('Получено: $data'),
    onError: print,
    onDone: () => print('Поток закрыт'),
  );

  await delay();
  snitch.e("1");

  await delay();
  snitch.e("2");
  await delay();

  snitch.closeStream();
  await subscription.cancel();

  await delay();
  snitch.i("3");

  await delay();
  snitch.e("4");

  await delay();
  snitch.e("5");

  snitch.e(
    UnimplementedError("Oops, something went wrong").toString(),
    stackTrace: StackTrace.current,
  );

  await fileOutputAdapter.close();

  print('snitch.logs ${snitch.logs.length}');
}

Future<void> delay() => Future.delayed(Duration(seconds: 1));
