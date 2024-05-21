import 'package:get_it/get_it.dart';
import 'package:snitch/core/database/migrations.dart';
import 'package:snitch/core/services/db.dart';
import 'package:snitch/features/bot/bloc/bot_bloc.dart';
import 'package:snitch/features/bot/repository/bot_local_repository.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';

final _locator = GetIt.instance;

Future<void> setupLocator() async {

  _locator.registerSingleton<DB>(DB(db: await DB.init()));
  _locator.registerSingleton<ThemeCubit>(ThemeCubit());

  _botInstances();

  await Migrations().up(_locator.get<DB>().db);

}


void _botInstances() {

  _locator.registerFactory<BotBloc>(() => BotBloc(repository: _locator.call()));
  _locator.registerSingleton<BotLocalRepository>(BotLocalRepository(db: _locator.get<DB>().db));



}