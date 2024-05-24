import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/shared/repository/base_local_repository_interface.dart';
import 'package:sqflite/sqflite.dart' show Database;

interface class IBotLocalRepository extends IBaseLocalRepository<BotModel> { }

class BotLocalRepository implements IBotLocalRepository {

  BotLocalRepository({ required this.db });


  final Database db;


  @override
  String get table => DbConstants.BOT_TABLE_NAME;


  @override
  Future<BotModel> create(BotModel model) async {
    try {
      final id = await db.insert(table, model.toJson());
      return model.copyWith(id: id);
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<bool> delete(int id) async {
    try {
      final result = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return result > 0;
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<bool> deleteAll() async {
    try {
      final result = await db.delete(table);
      return result > 0;
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<BotModel> read(String id) async {
    try {
      final maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
      if (maps.isEmpty) {
        throw Exception('Record not found');
      }
      return BotModel.fromJson(maps.first);
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<List<BotModel>> readAll() async {
    try {
      final maps = await db.query(table);
      return maps.map((e) => BotModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<BotModel> update(BotModel model) async {
    try {
      int result = await db.update(table, model.toJson(), where: 'id = ?', whereArgs: [model.id]);
      if (result == 0) {
        throw Exception('Record not found');
      }
      return model;
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<List<BotModel>> search(String query) async {
    try {
      final maps = await db.rawQuery("SELECT * FROM $table WHERE name LIKE '%$query%'");
      return maps.map((e) => BotModel.fromJson(e)).toList();
    }
    catch (e) {
      throw Exception(e);
    }
  }


}
