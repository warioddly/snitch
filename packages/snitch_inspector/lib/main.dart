import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch_inspector/feature/inspector/inspector_view.dart';
import 'package:snitch_inspector/feature/inspector_entry/inspector_entry_view.dart';
import 'package:snitch_inspector/shared/configs/scroll_behavior.dart';
import 'package:snitch_inspector/shared/ui/theme/ui_theme.dart';
import 'package:snitch_inspector/shared/utils/local_storage.dart';

void main() => runZonedGuarded($runner, $onCrash);

Future<void> $runner() async {
  await LocalStorage.instance.init();

  runApp(const MyApp());
}

void $onCrash(Object? error, StackTrace stackTrace) {
  log(
    'App Crashed',
    error: error,
    stackTrace: stackTrace,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snitch Inspector',
      themeMode: ThemeMode.dark,
      theme: UITheme.darkTheme,
      darkTheme: UITheme.darkTheme,
      scrollBehavior: const WebScrollBehavior(),
      initialRoute: '/',
      routes: {
        '/': (context) => const InspectorEntryView(),
        '/inspector': (context) => const InspectorView(),
      },
    );
  }
}
