import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/core/services/database/migrations.dart';
import 'package:sqflite/sqflite.dart';


class DB {

  late final Database _db;

  Database get db => _db;

  Future<DB> init() async {

    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, "${DbConstants.DB_NAME}.db");

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        debugPrint("Error creating database directory");
      }
   }

    _db = await openDatabase(path, version: DbConstants.DB_VERSION, readOnly: false, onOpen: (db) async => await Migrations.up(db));

    return this;
  }

}