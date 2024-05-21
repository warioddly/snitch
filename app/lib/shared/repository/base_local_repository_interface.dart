import 'package:snitch/shared/model/base_model_interface.dart';

abstract class IBaseLocalRepository<T extends IBaseModel> {

  const IBaseLocalRepository();

  String get table => throw UnimplementedError();

  Future<T> create(T model) async {
    throw UnimplementedError();
  }

  Future<T> read(String id) async {
    throw UnimplementedError();
  }

  Future<List<T>> readAll() async {
    throw UnimplementedError();
  }

  Future<T> update(T model) async {
    throw UnimplementedError();
  }

  Future<bool> delete(int id) async {
    throw UnimplementedError();
  }

  Future<bool> deleteAll() async {
    throw UnimplementedError();
  }

  Future<List<T>> search(String query) async {
    throw UnimplementedError();
  }

}