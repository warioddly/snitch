import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snitch/snitch.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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

  // final snitch = Snitch();
  // late final inspector = SnitchInspector(
  //   internetAddress: InternetAddress.anyIPv6,
  //   port: 8080,
  //   snitch: snitch,
  // );
  //
  // @override
  // void initState() {
  //   super.initState();
  //   snitch
  //     ..t("message")
  //     ..i("info")
  //     ..w("warning")
  //     ..e("error")
  //     ..d("debug")
  //     ..v("verbose");
  //
  //   inspector.serve();
  // }
  //
  // @override
  // void dispose() {
  //   inspector.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            // Text(snitch.logs.length.toString(),
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // snitch.t("Button pressed");
          setState(() { });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
