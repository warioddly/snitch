import 'package:flutter/cupertino.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/shared/migration/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

class TipsSeeder implements IBaseSeeder {


  @override
  String get table => DbConstants.TIP_TABLE_NAME;


  @override
  Future<void> seed(Database db) async {

    for (final tip in tips) {
      var json = tip.toJson();
      json.remove('id');
      await db.insert(table, json);
    }

    debugPrint('$table seeded');

  }

}