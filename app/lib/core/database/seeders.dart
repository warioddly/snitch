import 'package:snitch/features/bot/migrations/bots_seeder.dart';
import 'package:snitch/features/tips/migration/tips_categories_seeder.dart';
import 'package:snitch/features/tips/migration/tips_seeder.dart';
import 'package:snitch/shared/migration/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;


class Seeder {

  static Future<void> seed(Database db) async {

    final seeders = <IBaseSeeder>[
      BotSeeder(),
      TipCategorySeeder(),
      TipsSeeder(),
    ];

    for (final seeder in seeders) {
      await seeder.seed(db);
    }

  }

}