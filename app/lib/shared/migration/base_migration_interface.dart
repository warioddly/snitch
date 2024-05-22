import 'package:sqflite/sqflite.dart' show Database;


abstract class IBaseMigration {


  const IBaseMigration();


  String get table;


  Future<void> up(Database db);


  Future<void> down(Database db) async {
    db.execute('''
      DROP TABLE IF EXISTS $table
    ''');
  }


  Future<bool> isMigrated(Database db) async {
    return db.rawQuery('''
      SELECT name FROM sqlite_master WHERE type='table' AND name='$table'
    ''').then((value) => value.isNotEmpty);
  }


  Future<void> truncate(Database db) async {
    db.execute('''
      DELETE FROM $table
    ''');
  }

}