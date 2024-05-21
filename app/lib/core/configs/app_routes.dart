import 'package:flutter/material.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_create_view.dart';
import 'package:snitch/features/bot/view/bot_settings_view.dart';
import 'package:snitch/features/home/view/home_view.dart';
import 'package:snitch/features/navigation_wrapper/view/navigation_wrapper_view.dart';
import 'package:snitch/features/console/view/console_view.dart';
import 'package:snitch/features/profile/view/profile_settings_view.dart';
import 'package:snitch/features/profile/view/profile_theme_settings_view.dart';
import 'package:snitch/features/tips/view/tips_view.dart';


class AppRoutes {

  static const String initialRoute = NavigationWrapperView.route;

  static Map<String, Widget Function(BuildContext)> routes = {
    NavigationWrapperView.route: (context) => const NavigationWrapperView(),
    HomeView.route: (context) => const HomeView(),
    TipsView.route: (context) => const TipsView(),
    ProfileSettingsView.route: (context) => const ProfileSettingsView(),
    ProfileThemeSettingsView.route: (context) => const ProfileThemeSettingsView(),
    ConsoleView.route: (context) {
      final bot = ModalRoute.of(context)!.settings.arguments as BotModel;
      return ConsoleView(bot: bot);
    },
    BotSettingsView.route: (context) {
      final bot = ModalRoute.of(context)!.settings.arguments as BotModel;
      return BotSettingsView(bot: bot);
    },
    BotCreateView.route: (context) => const BotCreateView(),
  };

}