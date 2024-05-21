import 'package:snitch/shared/model/base_model_interface.dart';

abstract class IBaseLocalRepository<T extends IBaseModel> {

  const IBaseLocalRepository();

  String get table => (T as IBaseModel).table;

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

  Future<bool> delete(String id) async {
    throw UnimplementedError();
  }

  Future<bool> deleteAll() async {
    throw UnimplementedError();
  }

}