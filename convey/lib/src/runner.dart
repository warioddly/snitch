import 'package:process_run/process_run.dart';
import 'dart:io';

class Cmd {

  final Shell _shell = Shell();

  Future<List<ProcessResult>> run(String command) {
    return _shell.run(command);
  }

}
