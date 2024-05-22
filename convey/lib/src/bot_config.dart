import 'dart:convert';
import 'dart:io';
import 'package:convey/src/models/bot_model.dart';
import 'package:convey/core/constants/constants.dart';
import 'package:convey/core/helpers/path_helper.dart';
import 'package:path/path.dart';


class BotConfig {


  const BotConfig({
    required this.bot,
    required this.guildId,
  });


  final BotModel bot;
  final int guildId;


  factory BotConfig.fromJson(Map<String, dynamic> data) {
    try {
      return BotConfig(
          bot: BotModel.fromJson(data['bot']),
          guildId: data['guildId']
      );
    }
    catch (e) {
      throw Exception('Error parsing BotConfig: $e');
    }
  }


  Map<String, dynamic> toJson() {
    return {
      'bot': bot.toJson(),
      'guildId': guildId,
    };
  }


  static Future<BotConfig> init() async {

    final config = await getConfig();

    if (config == null) {
      print('Config is null');
      throw Exception('Config is null');
    }

    return BotConfig.fromJson(config);
  }


  static Future<Map<String, dynamic>?> getConfig() async {

    final configFile = join(PathHelper.getCurrentPath(), CONFIG_FILENAME);

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