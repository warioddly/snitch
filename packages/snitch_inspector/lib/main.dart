import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snitch Inspector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Inspector(),
    );
  }
}

class Inspector extends StatefulWidget {
  const Inspector({super.key});

  @override
  State<Inspector> createState() => _InspectorState();
}

class _InspectorState extends State<Inspector> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Snitch Console')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: uriController),
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
      floatingActionButton: FloatingActionButton(
        onPressed: getLogs,
        child: const Icon(Icons.http),
      ),
    );
  }
}
