import 'package:snitch/snitch.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/adapters/file_output_adapter.dart';

void main() async {

  final fileOutputAdapter = FileOutputAdapter("logs.txt");

  var snitch = Snitch(
    maxLogs: 21,
    adapters: <OutputAdapter>[
      // fileOutputAdapter,
      ConsoleOutputAdapter()
    ]
  );

  snitch
    ..t("message")
    ..i("info")
    ..w("warning")
    ..e("error")
    ..d("debug")
    ..v("verbose");

  snitch.e("message");
  snitch.e("message");
  snitch.e(FormatException("Oops, something went wrong").toString(), stackTrace: StackTrace.current);

  await fileOutputAdapter.close();

  print('snitch.logs ${snitch.logs.length}');
}

