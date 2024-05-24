import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/user/model/user_config_model.dart';
import 'package:snitch/features/user/repository/user_local_repository.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {


  UserConfigBloc({ required this.repository }) : super(UserConfigInitial()) {
    on<UserConfigReadEvent>(_readConfig);
    on<UserConfigCreateEvent>(_createConfig);
  }


  final UserLocalRepository repository;


  Future<void> _readConfig(UserConfigReadEvent event, emit) async {

    try {

      final configs = await repository.getConfigs();

      if (configs == null) {
        emit(const UserConfigEmpty());
      }
      else {
        emit(UserConfigReaded(configs));
      }

    }
    catch (e) {
      emit(UserConfigError(e.toString()));
    }

  }


  Future<void> _createConfig(UserConfigCreateEvent event, emit) async {

      try {
        emit(const UserConfigCreating());

        await repository.deleteAll();

        final configs = await repository.create(event.config);

        if (configs == null) {
          emit(const UserConfigEmpty());
        }
        else {
          emit(UserConfigReaded(configs));
        }

      }
      catch (e) {
        emit(UserConfigError(e.toString()));
      }
  }


}
