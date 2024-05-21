import 'package:snitch/features/bot/migrations/bot_seeder.dart';
import 'package:snitch/shared/seeder/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart';


class Seeder {

  static Future<void> seed(Database db) async {

    final seeders = <IBaseSeeder>[
      BotSeeder(),
    ];

    for (final seeder in seeders) {
      await seeder.seed(db);
    }

  }

}