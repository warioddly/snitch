import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/shared/seeder/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart';

class BotSeeder extends IBaseSeeder<BotModel> {

  @override
  Future<void> seed(Database db, [count = 15]) async {

    final bots = BotFaker.createBots(count);

    for (final bot in bots) {
      await db.insert(table, bot.toJson());
    }

  }

}