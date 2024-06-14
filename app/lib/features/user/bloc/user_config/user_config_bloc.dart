import 'package:discord/discord.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/user/models/user_config_model.dart';
import 'package:snitch/features/user/repositories/user_local_repository.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {


  UserConfigBloc({ required this.repository }) : super(UserConfigInitial()) {
    on<UserConfigReadEvent>(_read);
    on<UserConfigCreateEvent>(_create);
    on<UserConfigUpdateEvent>(_update);
  }


  final UserLocalRepository repository;
  final _discord = const DiscordValidate();


  Future<void> _read(UserConfigReadEvent event, emit) async {

    try {

      final result = await repository.getConfigs();

      result.fold(
        (l) => throw l,
        (configs) => configs == null
            ? emit(UserConfigEmpty())
            : emit(UserConfigReaded(configs))
      );

    }
    catch (e) {
      emit(UserConfigError(e.toString()));
    }

  }


  Future<void> _create(UserConfigCreateEvent event, emit) async {

      try {
        emit(UserConfigCreating());

        final config = event.config;

        final checkResult = await _discord.check(config.token, config.guildId);

        if (checkResult is! DiscordTokenSuccessStatus) {
          throw checkResult.message;
        }

        await repository.deleteAll();

        final result = await repository.create(event.config);

        result.fold(
            (l) => throw l,
            (configs) => emit(UserConfigCreated(configs))
        );

      }
      catch (e) {
        emit(UserConfigCreateError(e.toString()));
      }
  }


  Future<void> _update(UserConfigUpdateEvent event, emit) async {

      try {
        emit(UserConfigUpdating());

        final config = event.config;

        final checkResult = await _discord.check(config.token, config.guildId);

        if (checkResult is! DiscordTokenSuccessStatus) {
          throw checkResult.message;
        }

        final result = await repository.update(event.config);

        result.fold(
            (l) => throw l,
            (configs) => emit(UserConfigUpdated(configs))
        );

      }
      catch (e) {
        emit(UserConfigUpdateError(e.toString()));
      }
  }


}
