import 'package:either_dart/either.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/core/services/error/failure.dart';
import 'package:snitch/features/commands/models/command_model.dart';
import 'package:snitch/shared/repository/base_local_repository_interface.dart';


class CommandLocalRepository extends IBaseLocalRepository<CommandModel> {

  const CommandLocalRepository({required super.db});


  @override
  String get table => DbConstants.COMMANDS_TABLE_NAME;


  @override
  Future<Either<Failure, CommandModel>> create(CommandModel model) async {
    try {
      final id = await db.insert(table, model.toJson());
      return Right(model.copyWith(id: id));
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, List<CommandModel>>> readAll()async {
    try {
      final maps = await db.query(table);
      if (maps.isEmpty) {
        throw Exception('Record not found');
      }
      return Right(maps.map((e) => CommandModel.fromJson(e)).toList());
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, CommandModel>> update(CommandModel model) async {
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
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      final result = await db.delete(table, where: 'id = ?', whereArgs: [id]);
      return Right(result > 0);
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, List<CommandModel>>> search(String query) async {
    try {
      final maps = await db.query(table, where: 'command LIKE ?', whereArgs: ['%$query%']);
      return Right(maps.map((e) => CommandModel.fromJson(e)).toList());
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


}
