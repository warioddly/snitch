import 'package:flutter/cupertino.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/shared/migration/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

class BotSeeder implements IBaseSeeder {


  @override
  String get table => DbConstants.BOT_TABLE_NAME;


  @override
  Future<void> seed(Database db) async {

    final bots = BotFaker.createBots(15, true);

    for (final bot in bots) {
      var botJson = bot.toJson();
      botJson.remove('id');
      await db.insert(table, botJson);
    }

    debugPrint('$table seeded');

  }

}