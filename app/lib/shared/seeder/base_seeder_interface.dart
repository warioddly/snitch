
import 'package:snitch/shared/model/base_model_interface.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IBaseSeeder<T extends IBaseModel> {

  const IBaseSeeder();

  String get table => (T as IBaseModel).table;

  Future<void> seed(Database db, [count = 15]) async {
    throw UnimplementedError();
  }


}