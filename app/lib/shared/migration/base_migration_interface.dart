import 'package:snitch/shared/model/base_model_interface.dart';
import 'package:sqflite/sqflite.dart';



abstract class IBaseMigration<T extends IBaseModel> {


  const IBaseMigration();


  String get table => (T as IBaseModel).table;


  Future<void> up(Database db) {
    throw UnimplementedError();
  }


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


}