import 'package:either_dart/either.dart';
import 'package:snitch/core/constants/db_constants.dart';
import 'package:snitch/core/services/error/failure.dart';
import 'package:snitch/features/user/models/user_config_model.dart';
import 'package:snitch/shared/repository/base_local_repository_interface.dart';


class IUserLocalRepository<T> extends IBaseLocalRepository<UserConfigModel> {
  const IUserLocalRepository({required super.db});

  Future<Either<Failure, T?>> getConfigs() {
    throw UnimplementedError();
  }

}

class UserLocalRepository extends IUserLocalRepository<UserConfigModel> {

  const UserLocalRepository({required super.db});

  @override
  String get table => DbConstants.USER_CONFIG_TABLE_NAME;


  @override
  Future<Either<Failure, UserConfigModel>> create(UserConfigModel model) async {
    try {
      final id = await db.insert(table, model.toJson());
      return Right(model.copyWith(id: id));
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, UserConfigModel>> read(int id) async {
    try {
      final maps = await db.query(table, where: 'id = ?', whereArgs: [id]);
      if (maps.isEmpty) {
        throw Exception('Record not found');
      }
      return Right(UserConfigModel.fromJson(maps.first));
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }


  @override
  Future<Either<Failure, UserConfigModel>> update(UserConfigModel model) async {
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
  Future<Either<Failure, UserConfigModel?>> getConfigs() async {
    try {
      final maps = await db.query(table);
      if (maps.isEmpty) {
        return const Right(null);
      }
      return Right(UserConfigModel.fromJson(maps.first));
    } catch (e, s) {
      return Left(Failure(e, s));
    }
  }

}
