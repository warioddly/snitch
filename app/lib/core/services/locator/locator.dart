import 'package:flutter/cupertino.dart';
import 'package:snitch/core/services/database/db.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/bloc/bot_search_bloc/bot_search_bloc.dart';
import 'package:snitch/features/bot/repositories/bot_local_repository.dart';
import 'package:snitch/features/commands/bloc/command_bloc.dart';
import 'package:snitch/features/commands/repositories/command_local_repository.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/features/user/bloc/user_config/user_config_bloc.dart';
import 'package:snitch/features/user/repositories/user_local_repository.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';


Map<Type, dynamic> _$getIt = {};


T getIt<T>() {
  final instance = _$getIt[T];
  return (instance is T ? instance : instance()) as T;
}


void getItRegister<T>([T? instance]) {
  _$getIt[T] = instance;
}


void getItRegisterFactory<T>(T Function() factory) {
  _$getIt[T] = factory;
}


Future<void> setupLocator() async {

  debugPrint('Setting up locator');


  getItRegister<DB>(await DB().init());
  getItRegister<ThemeCubit>(ThemeCubit());


  getItRegister<BotLocalRepository>(BotLocalRepository(db: getIt<DB>().db));
  getItRegisterFactory<BotsBloc>(() => BotsBloc(repository: getIt()));
  getItRegisterFactory<BotSearchBloc>(() => BotSearchBloc(repository: getIt()));
  getItRegisterFactory<BotActionBloc>(() => BotActionBloc(repository: getIt()));


  getItRegister<UserLocalRepository>(UserLocalRepository(db: getIt<DB>().db));
  getItRegisterFactory<UserBloc>(() => UserBloc());
  getItRegisterFactory<UserBotBloc>(() => UserBotBloc());
  getItRegisterFactory<UserConfigBloc>(() => UserConfigBloc(repository: getIt()));


  getItRegister<CommandLocalRepository>(CommandLocalRepository(db: getIt<DB>().db));
  getItRegisterFactory<CommandBloc>(() => CommandBloc(repository: getIt()));


  debugPrint('Locator setup complete');

}
