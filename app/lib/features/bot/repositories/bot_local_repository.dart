import 'package:either_dart/either.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/core/services/error/failure.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/shared/repository/base_local_repository_interface.dart';

abstract class IBotLocalRepository<T> extends IBaseLocalRepository<BotModel> {
  const IBotLocalRepository({required super.db});

  Future<Either<Failure, bool>> hasToken(String token, [int? id]);

}


class BotLocalRepository extends IBotLocalRepository<BotModel> {


  const BotLocalRepository({ required super.db });


  @override
  String get table => DbConstants.BOT_TABLE_NAME;


  @override
  Future<Either<Failure, BotModel>> create(BotModel model) async {
    try {
      final id = await db.insert(table, model.toJson());
      return Right(model.copyWith(id: id));
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      final result = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return Right(result > 0);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, bool>> deleteAll() async {
    try {
      final result = await db.delete(table);
      return Right(result > 0);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, BotModel>> read(int id) async {
    try {
      final maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
      if (maps.isEmpty) {
        throw Exception('Record not found');
      }
      return Right(BotModel.fromJson(maps.first));
    }  catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, List<BotModel>>> readAll() async {
    try {
      final maps = await db.query(table);
      return Right(maps.map((e) => BotModel.fromJson(e)).toList());
    }  catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, BotModel>> update(BotModel model) async {
    try {
      int result = await db.update(table, model.toJson(), where: 'id = ?', whereArgs: [model.id]);
      if (result == 0) {
        throw Exception('Record not found');
      }
      return Right(model);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, List<BotModel>>> search(String query) async {
    try {
      final maps = await db.rawQuery("SELECT * FROM $table WHERE name LIKE '%$query%'");
      return Right(maps.map((e) => BotModel.fromJson(e)).toList());
    }
     catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, bool>> hasToken(String token, [int? id]) async {
    try {
      
      if (id != null) {
        final maps = await db.query(table, where: 'token = ? AND id != ?', whereArgs: [token, id]);
        return Right(maps.isNotEmpty);
      }
      
      final maps = await db.query(table, where: 'token = ?', whereArgs: [token]);
      return Right(maps.isNotEmpty);
    }
    catch (e, s) {
      return Left(Failure(e, s));
    }
  }


}
