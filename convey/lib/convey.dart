import 'package:convey/src/bot.dart';
import 'package:convey/src/bot_config.dart';


Future<void> runConvey() async {

  final config = await BotConfig.init();
  final bot = Bot(config: config);
  bot.start();

}