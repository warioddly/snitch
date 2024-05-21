import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:snitch/shared/model/base_model_interface.dart';
import 'package:sqflite/sqflite.dart';

class BotMigration extends IBaseMigration<BotModel> {

  const BotMigration();

  @override
  Future<void> up(Database db) async {

    print("model $table");
    print("is IBaseModel ${table is IBaseModel}");

    // await db.execute('''
    //   CREATE TABLE $table (
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     name TEXT NOT NULL,
    //     description TEXT NOT NULL,
    //     image TEXT NOT NULL,
    //     token TEXT NOT NULL,
    //     status TEXT NOT NULL,
    //     createdAt TEXT NOT NULL,
    //     updatedAt TEXT NOT NULL
    //   )
    // ''');

  }

}