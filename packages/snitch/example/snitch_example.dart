import 'package:snitch/snitch.dart';

void main() {

  var snitch = Snitch(
    maxLogs: 21,
    // adapters: <OutputAdapter>[
    //   // FileOutputAdapter('path/to/log.txt'),
    //   // RemoteOutputAdapter('https://example.com/logs'),
    // ]
  );

  snitch.e("message");
  snitch.e("message");
  snitch.e("message");

  print('snitch.logs ${snitch.logs.length}');
}

