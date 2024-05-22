import 'dart:convert';
import 'dart:io';
import 'package:convey/src/bot_model.dart';
import 'package:convey/core/constants/constants.dart';
import 'package:convey/core/helpers/path_helper.dart';
import 'package:path/path.dart';


class BotConfig {

  const BotConfig({required this.bot});

  final BotModel bot;

  static Future<BotConfig> init() async {

    final config = await getConfig();

    if (config == null) {
      print('Config is null');
      throw Exception('Config is null');
    }

    final bot = BotModel.fromJson(config);

    if (bot.owner == null) {
      print('Bot owner is not set');
      throw Exception('Bot owner is not set');
    }

    return BotConfig(bot: bot);

  }


  static Future<Map<String, dynamic>?> getConfig() async {

    final configFile = join(PathHelper.getCurrentPath(), Constants.CONFIG_FILENAME);

    if (PathHelper.exists(configFile) == null) {
      File(configFile).createSync();
      print('Config file created at: $configFile');
    }

    final Map<String, dynamic> config = {};
    final content = await File(configFile).readAsString();

    if (content.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(content);

      if (json.isNotEmpty) {
        config.addAll(json);
      }
      else {
        print('Config file is empty');
        throw Exception('Config file is empty');
      }

    }
    else {
      print('Config file is empty');
      throw Exception('Config file is empty');
    }

    return config;
  }

}