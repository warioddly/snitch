import 'package:path/path.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:sqflite/sqflite.dart';


class DB {

  final Database db;

  DB({required this.db});

  static Future<Database> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "$APP_DB_NAME.db");
    return await openDatabase(path, version: 1);
  }

}