import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snitch/snitch.dart';
import 'package:snitch_serve/snitch_serve.dart';
// import 'package:snitch_inspector_serve/snitch_inspector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final snitch = Snitch(adapters: []);

  late final snitchServe = SnitchServe(address: InternetAddress.anyIPv6, port: 4040, snitch: snitch)
    ..printAddresses()
    ..start();

  @override
  void dispose() {
    snitchServe.close();
    super.dispose();
  }

  void addLogs() {
    snitch
      ..t("message")
      ..i("info")
      ..w("warning")
      ..e("error")
      ..d("debug")
      ..v("verbose");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: snitch.logs.length,
        itemBuilder: (context, index) {
          final log = snitch.logs[index];
          return Text('${log.name} ${log.message}');
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: addLogs, child: const Icon(Icons.add)),
    );
  }
}

//
//
// class ConsoleAdapter extends OutputAdapter {
//   ConsoleAdapter();
//
//   @override
//   void log(Log record) {
//     // if (!filter.call(log.level)) {
//     //   return;
//     // }
//     Zone.root.print(record.message);
//   }
// }
