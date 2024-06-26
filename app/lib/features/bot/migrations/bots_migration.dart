import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

class BotMigration extends IBaseMigration {


  const BotMigration();


  @override
  String get table => DbConstants.BOT_TABLE_NAME;


  @override
  Future<void> up(Database db) async {

    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        image TEXT,
        token TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

  }

}