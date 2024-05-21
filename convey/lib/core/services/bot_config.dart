import 'dart:io';
import 'package:convey/core/constants/constants.dart';
import 'package:convey/core/helpers/path_helper.dart';
import 'package:path/path.dart';

class BotConfig {

  BotConfig._internal();

  static final BotConfig instance = BotConfig._internal();

  factory BotConfig() {
    return instance;
  }

  static Future<void> init() async {

    final configFile = join(PathHelper.getCurrentPath(), Constants.CONFIG_FILENAME);

    if (PathHelper.exists(configFile) == null) {
      File(configFile).createSync();
      print('Config file created at: $configFile');
    }

  }

}