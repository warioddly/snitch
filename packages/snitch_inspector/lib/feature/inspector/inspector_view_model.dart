import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:snitch_inspector/shared/constants/storage_key.dart';
import 'package:snitch_inspector/shared/utils/local_storage.dart';
import 'package:snitch_interface/snitch_interface.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InspectorViewModel extends ViewModel {
  InspectorViewModel() {
    _init();
  }

  final _storage = LocalStorage.instance;
  late final String _targetUrl;

  final _logs = List<Log>.generate(
    100,
    (_) => Log(
      message: 'Mock log message',
      level: DebugLevel(),
      timestamp: DateTime.now().millisecondsSinceEpoch,
      metadata: {'key': 'value'},
      error: 'Mock error',
      stackTrace: StackTrace.current,
    ),
  );

  List<Log> get logs => _logs;

  Log getLogAt(int index) => _logs[index];

  void _init() async {
    _targetUrl = await _storage.get(StorageKey.targetUrl);
    notifyListeners();
  }

  // void getLogs() async {
  //   // try {
  //   //   final response = await http.get(Uri.parse(_targetUrl));
  //   //   if (response.statusCode == 200) {
  //   //     logs.add(response.body);
  //   //   } else {
  //   //     logs.add('Ошибка сервера: ${response.statusCode}');
  //   //   }
  //   // } catch (e, s) {
  //   //   logs.add('$e $s');
  //   // }
  //   //
  //   // notifyListeners();
  // }
  //
  // void getSocketLogs() async {
  //   // final channel = WebSocketChannel.connect(Uri.parse(_targetUrl));
  //   //
  //   // await channel.ready;
  //   //
  //   // channel.stream.listen(
  //   //   (event) {
  //   //     try {
  //   //       final data = jsonDecode(event);
  //   //       logs.add(data.toString());
  //   //     } catch (_) {
  //   //       logs.add(event.toString());
  //   //     }
  //   //     notifyListeners();
  //   //   },
  //   //   onError: (error) {
  //   //     logs.add('WebSocket error: $error');
  //   //     notifyListeners();
  //   //   },
  //   //   onDone: () {
  //   //     logs.add('WebSocket closed');
  //   //     notifyListeners();
  //   //   },
  //   // );
  // }
}
