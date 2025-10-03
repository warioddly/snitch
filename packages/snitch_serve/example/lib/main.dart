import 'package:flutter/material.dart';
import 'dart:async';

import 'package:snitch_serve/snitch_serve.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _snitchServe = SnitchServe();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Future<void> initPlatformState() =>
  //     [_snitchServe.start(), _snitchServe.printAddresses()].wait;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Snitch Serve')),
        body: Center(child: Text('Running on:')),
      ),
    );
  }
}
