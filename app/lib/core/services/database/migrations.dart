import 'package:flutter/foundation.dart';
import 'package:snitch/features/bot/migrations/bots_migration.dart';
import 'package:snitch/features/user/migrations/user_config_migration.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;


class Migrations {

  static const migrations = <IBaseMigration>[
    BotMigration(),
    UserConfigMigration(),
    // TipCategoriesMigration(),
    // TipsMigration()
  ];


  static Future<void> up(Database db) async {

    for (final migration in migrations) {
      if (!await migration.isMigrated(db)) {
        await migration.up(db);
        debugPrint('Table ${migration.table} created');
      }
      else {
        debugPrint('Table ${migration.table} already exists');
      }
    }

  }

  static Future<void> down(Database db) async {
    for (final migration in migrations) {
      await migration.down(db);
    }
  }


}