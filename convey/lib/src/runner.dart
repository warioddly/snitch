
import 'package:process_run/process_run.dart';
import 'dart:io';

class Cmd {

  final Shell _shell = Shell();

  Future<List<ProcessResult>> run(String command) async {
    return _shell.run(command);
  }

  Future<Shell> cd(String path) async {
    return _shell.cd(path);
  }

}
