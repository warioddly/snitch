import 'package:snitch/snitch.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/adapters/file_output_adapter.dart';
import 'package:snitch/src/adapters/remote_output_adapter.dart';
import 'package:snitch/src/levels/level.dart';

void main() async {
  final fileOutputAdapter = FileOutputAdapter(
    "logs.txt",
    filter: (Level level) => level.level == WarningLevel.value,
  );

  final remoteOutputAdapter = RemoteOutputAdapter(
    filter: (Level level) => level.level >= VerboseLevel.value &&
        level.level <= WarningLevel.value,
  );

  var snitch = Snitch(
    maxLogs: 21,
    adapters: <OutputAdapter>[
      fileOutputAdapter,
      ConsoleOutputAdapter(),
      remoteOutputAdapter,
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
    (data) {
      print('Получено: $data');
    },
    onError: (error) {
      print('Ошибка: $error');
    },
    onDone: () {
      print('Поток закрыт');
    },
    cancelOnError: false,
  );

  await Future.delayed(Duration(seconds: 1));
  snitch.e("1");

  await Future.delayed(Duration(seconds: 1));
  snitch.e("2");

  snitch.closeStream();
  await subscription.cancel();

  await Future.delayed(Duration(seconds: 1));
  snitch.e("3");

  subscription = snitch.stream().listen(
    (data) {
      print('Получено: $data');
    },
    onError: (error) {
      print('Ошибка: $error');
    },
    onDone: () {
      print('Поток закрыт');
    },
    cancelOnError: false,
  );

  await Future.delayed(Duration(seconds: 1));
  snitch.e("4");

  await Future.delayed(Duration(seconds: 1));
  snitch.e("5");

  snitch.closeStream();
  await subscription.cancel();

  snitch.e(
    UnimplementedError("Oops, something went wrong").toString(),
    stackTrace: StackTrace.current,
  );

  await fileOutputAdapter.close();

  print('snitch.logs ${snitch.logs.length}');
}
