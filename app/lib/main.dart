import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/core/configs/app_routes.dart';
import 'package:snitch/core/configs/scroll_behavior.dart';
import 'package:snitch/core/themes/theme.dart';
import 'package:snitch/core/services/locator.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/wrapper/widgets/internet_connectivity_checker_widget.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/features/user/bloc/user_config/user_config_bloc.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I.get<UserBloc>()),
        BlocProvider(create: (context) => GetIt.I.get<UserConfigBloc>()),
        BlocProvider(create: (context) => GetIt.I.get<UserBotBloc>()),
        BlocProvider(create: (context) => GetIt.I.get<BotsBloc>()),
        BlocProvider(create: (context) => GetIt.I.get<BotActionBloc>()),
        BlocProvider(create: (context) => GetIt.I.get<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, SnitchThemeType>(
        builder: (context, state) {
          return MaterialApp(
            theme: SnitchTheme.getTheme(state),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return InternetConnectivityCheckerWidget(
                child: BotToastInit()(context, child),
              );
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            scrollBehavior: const MyScrollBehavior(),
            initialRoute: AppRoutes.initialRoute,
            routes: AppRoutes.routes
          );
        },
      ),
    );
  }
}
