import 'package:sqflite/sqlite_api.dart';

interface class IBaseSeeder {

  const IBaseSeeder();

  String get table => throw UnimplementedError();

  Future<void> seed(Database db, [count = 15]) async {
    throw UnimplementedError();
  }

}