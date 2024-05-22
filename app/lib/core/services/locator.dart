import 'package:get_it/get_it.dart';
import 'package:snitch/core/services/db.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/bloc/bot_search_bloc/bot_search_bloc.dart';
import 'package:snitch/features/bot/repository/bot_local_repository.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';

final _locator = GetIt.instance;

Future<void> setupLocator() async {

  _locator.registerSingleton<DB>(DB(db: await DB.init()));
  _locator.registerSingleton<ThemeCubit>(ThemeCubit());

  _botInstances();

}


void _botInstances() {

  _locator.registerFactory<BotsBloc>(() => BotsBloc(repository: _locator.call()));
  _locator.registerFactory<BotSearchBloc>(() => BotSearchBloc(repository: _locator.call()));
  _locator.registerFactory<BotActionBloc>(() => BotActionBloc(repository: _locator.call()));
  _locator.registerSingleton<BotLocalRepository>(BotLocalRepository(db: _locator.get<DB>().db));

}