import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

class TipCategoriesMigration extends IBaseMigration {

  const TipCategoriesMigration();


  @override
  String get table => DbConstants.TIP_CATEGORIES_TABLE_NAME;


  @override
  Future<void> up(Database db) async {

    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
      )
    ''');

  }

}