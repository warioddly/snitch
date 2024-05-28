import 'package:discord/discord.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snitch/features/user/model/user_config_model.dart';
import 'package:snitch/features/user/repository/user_local_repository.dart';

part 'user_config_event.dart';
part 'user_config_state.dart';

class UserConfigBloc extends Bloc<UserConfigEvent, UserConfigState> {


  UserConfigBloc({ required this.repository }) : super(UserConfigInitial()) {
    on<UserConfigReadEvent>(_read);
    on<UserConfigCreateEvent>(_create);
    on<UserConfigUpdateEvent>(_update);
  }


  final UserLocalRepository repository;
  final discordValidator = const DiscordValidator();


  Future<void> _read(UserConfigReadEvent event, emit) async {

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


  Future<void> _create(UserConfigCreateEvent event, emit) async {

      try {
        emit(const UserConfigCreating());

        final config = event.config;

        final result = await discordValidator.check(config.token, config.guildId);

        if (result is! DiscordValidatorStatusSuccess) {
          throw result.message;
        }

        await repository.deleteAll();

        final configs = await repository.create(event.config);

        if (configs == null) {
          throw 'Error while creating config';
        }
        else {
          emit(UserConfigCreated(configs));
        }

      }
      catch (e) {
        emit(UserConfigCreateError(e.toString()));
      }
  }


  Future<void> _update(UserConfigUpdateEvent event, emit) async {

      try {
        emit(const UserConfigUpdating());

        final config = event.config;

        final result = await discordValidator.check(config.token, config.guildId);

        if (result is! DiscordValidatorStatusSuccess) {
          throw result.message;
        }

        final configs = await repository.update(event.config);

        emit(UserConfigUpdated(configs));

      }
      catch (e) {
        emit(UserConfigUpdateError(e.toString()));
      }
  }


}
