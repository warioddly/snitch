import 'package:snitch/features/bot/migrations/bot_migration.dart';
import 'package:snitch/shared/migration/base_migration_interface.dart';
import 'package:sqflite/sqflite.dart';


class Migrations {

  static const migrations = <IBaseMigration>[
  ];


  Future<void> up(Database db) async {

    await const BotMigration().up(db);

    // for (final migration in migrations) {
    //   await const BotMigration().up(db);
    // }

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