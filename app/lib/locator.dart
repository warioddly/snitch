import 'package:get_it/get_it.dart';
import 'package:snitch/core/services/db.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';


final _locator = GetIt.instance;

Future<void> setupLocator() async {

  _locator.registerSingleton<DB>(DB(db: await DB.open()));
  _locator.registerSingleton<ThemeCubit>(ThemeCubit());


}