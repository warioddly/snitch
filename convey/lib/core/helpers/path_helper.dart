import 'dart:io';
import 'package:convey/core/constants/constants.dart';
import 'package:path/path.dart';

class PathHelper {


  static String getCurrentPath() {
    return Directory.current.path;
  }


  static String getConfigFilePath() {
    return join(getCurrentPath(), Constants.CONFIG_FILENAME);
  }


  static String? exists(String path) {
    return File(path).existsSync() ? path : null;
  }


}