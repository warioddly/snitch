import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:snitch/core/configs/app_routes.dart';
import 'package:snitch/core/configs/scroll_behavior.dart';
import 'package:snitch/core/themes/theme.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/wrapper/widgets/internet_connectivity_checker_widget.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
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
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<UserBotBloc>()),
        BlocProvider(create: (context) => getIt<BotsBloc>()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, SnitchThemeType>(
        builder: (context, state) {
          return SafeArea(
            child: MaterialApp(
                theme: SnitchTheme.getTheme(state),
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                    child: InternetConnectivityCheckerWidget(
                      child: BotToastInit()(context, child),
                    ),
                  );
                },
                navigatorObservers: [BotToastNavigatorObserver()],
                scrollBehavior: const MyScrollBehavior(),
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes
            ),
          );
        },
      ),
    );
  }
}
