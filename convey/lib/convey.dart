import 'dart:convert';
import 'dart:io';

import 'package:convey/core/services/locator.dart';

Future<void> runConvey() async {
  print('Running the app...');

  await setupLocator();

  ProcessResult results =  await Process.run('cmd.exe', ['ipconfig']);
  print(results.stdout);
}