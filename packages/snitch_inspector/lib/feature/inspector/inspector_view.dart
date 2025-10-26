import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snitch_inspector/feature/inspector/inspector_view_model.dart';
import 'package:snitch_inspector/shared/base/view_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InspectorView extends StatefulWidget {
  const InspectorView({super.key});

  @override
  State<InspectorView> createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  final vm = InspectorViewModel();

  final uriController = TextEditingController();
  final logs = <String>[];

  void getLogs() async {
    try {
      final response = await http.get(Uri.parse(uriController.text));
      if (response.statusCode == 200) {
        logs.add(response.body);
      } else {
        logs.add('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e, s) {
      logs.add('$e $s');
    }

    setState(() {});
  }

  void getSocketLogs() async {
    final channel = WebSocketChannel.connect(Uri.parse(uriController.text));

    await channel.ready;

    channel.stream.listen(
      (event) {
        try {
          final data = jsonDecode(event);
          logs.add(data.toString());
        } catch (_) {
          logs.add(event.toString());
        }
        setState(() {});
      },
      onError: (error) {
        logs.add('WebSocket error: $error');
        setState(() {});
      },
      onDone: () {
        logs.add('WebSocket closed');
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: vm,
      child: Scaffold(
        appBar: AppBar(title: Text('Snitch Console')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    return Text(logs[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: getLogs,
              child: const Icon(Icons.http),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: getSocketLogs,
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
