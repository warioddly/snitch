import 'package:convey/core/services/bot_config.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.instance;

Future<void> setupLocator() async {

  BotConfig.init();

}
