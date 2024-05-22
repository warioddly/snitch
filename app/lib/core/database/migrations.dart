import 'package:snitch/features/bot/migrations/bots_migration.dart';
import 'package:snitch/features/tips/migration/tips_categories_migration.dart';
import 'package:snitch/features/tips/migration/tips_migration.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;


class Migrations {

  static const migrations = <IBaseMigration>[
    BotMigration(),
    TipCategoriesMigration(),
    TipsMigration()
  ];


  static Future<void> up(Database db) async {

    for (final migration in migrations) {
      if (!await migration.isMigrated(db)) {
        await migration.up(db);
        print('Table ${migration.table} created');
      }
      else {
        print('Table ${migration.table} already exists');
      }
    }

  }

  static Future<void> down(Database db) async {

    for (final migration in migrations) {
      await migration.down(db);
    }

  }

  static Future<bool> isMigrated(Database db) async {

    for (final migration in migrations) {
      final isMigrated = await migration.isMigrated(db);
      if (!isMigrated) return false;
    }

    return false;
  }

}