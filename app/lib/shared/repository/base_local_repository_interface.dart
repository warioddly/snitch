import 'package:snitch/core/services/error/failure.dart';
import 'package:snitch/shared/model/base_model_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:either_dart/either.dart';

abstract class IBaseLocalRepository<T extends IBaseModel> {

  const IBaseLocalRepository({ required this.db });

  String get table => throw UnimplementedError();

  final Database db;

  Future<Either<Failure, T>> create(T model) {
    throw UnimplementedError();
  }

  Future<Either<Failure, T>> read(int id) {
    throw UnimplementedError();
  }

  Future<Either<Failure, List<T>>> readAll() async {
    throw UnimplementedError();
  }

  Future<Either<Failure, T>> update(T model) async {
    throw UnimplementedError();
  }

  Future<Either<Failure, bool>> delete(int id) async {
    try {
      final result = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return Right(result > 0);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }

  Future<Either<Failure, bool>> deleteAll() async {
    try {
      final result = await db.delete(table);
      return Right(result > 0);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }

  Future<Either<Failure, List<T>>> search(String query) async {
    throw UnimplementedError();
  }

}