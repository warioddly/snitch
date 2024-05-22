import 'package:snitch/shared/model/base_model_interface.dart';
import 'package:sqflite/sqflite.dart';

abstract class IBaseLocalRepository<T extends IBaseModel> {

  const IBaseLocalRepository({ required this.db });

  String get table => throw UnimplementedError();

  final Database db;

  Future<T?> create(T model) {
    throw UnimplementedError();
  }

  Future<T?> read(int id) {
    throw UnimplementedError();
  }

  Future<List<T>> readAll() async {
    throw UnimplementedError();
  }

  Future<T> update(T model) async {
    throw UnimplementedError();
  }

  Future<bool> delete(int id) async {
    try {
      final result = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return result > 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteAll() async {
    try {
      final result = await db.delete(table);
      return result > 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<T>> search(String query) async {
    throw UnimplementedError();
  }

}