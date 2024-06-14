import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

class CommandMigration extends IBaseMigration {


  const CommandMigration();


  @override
  String get table => DbConstants.COMMANDS_TABLE_NAME;


  @override
  Future<void> up(Database db) async {

    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        command TEXT NOT NULL
      )
    ''');

  }

}