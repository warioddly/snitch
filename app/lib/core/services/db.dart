import 'dart:io';
import 'package:path/path.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/core/database/migrations.dart';
import 'package:sqflite/sqflite.dart';


class DB {

  final Database db;

  const DB({required this.db});

  static Future<Database> init() async {

    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "${DbConstants.DB_NAME}.db");

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
   }

    return openDatabase(path, version: DbConstants.DB_VERSION, readOnly: false, onOpen: (db) async {
      await Migrations.up(db);
    });

  }

}