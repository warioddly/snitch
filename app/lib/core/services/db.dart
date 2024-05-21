import 'dart:io';
import 'package:path/path.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:sqflite/sqflite.dart';


class DB {

  final Database db;

  DB({required this.db});

  static Future<Database> init() async {

    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "$APP_DB_NAME.db");

    final exists = await databaseExists(path);

    print("exists $exists");

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
   }

    return openDatabase(path, version: 1, onOpen: (db) async {

      // if (exists) {
      //   await Migrations().up(db);
      //   await Seeder.seed(db);
      // }

    });

  }

}