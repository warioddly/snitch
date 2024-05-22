import 'package:flutter/cupertino.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/shared/migration/base_seeder_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;


class TipCategorySeeder implements IBaseSeeder {


  @override
  String get table => DbConstants.TIP_CATEGORIES_TABLE_NAME;


  @override
  Future<void> seed(Database db) async {

    for (final tip in TipCategory.values) {
      await db.insert(table, {"name": tip});
    }

    debugPrint('$table seeded');
  }

}