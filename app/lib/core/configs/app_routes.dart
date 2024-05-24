import 'package:flutter/material.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_all_list_view.dart';
import 'package:snitch/features/bot/view/bot_create_view.dart';
import 'package:snitch/features/bot/view/bot_home_view.dart';
import 'package:snitch/features/bot/view/bot_settings_view.dart';
import 'package:snitch/features/home/view/home_view.dart';
import 'package:snitch/features/navigation_wrapper/view/navigation_wrapper_view.dart';
import 'package:snitch/features/console/view/console_view.dart';
import 'package:snitch/features/onboarding/view/onboarding_view.dart';
import 'package:snitch/features/user/view/user_settings_view.dart';
import 'package:snitch/features/user/view/user_theme_settings_view.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/features/tips/view/tips_view.dart';


class AppRoutes {

  static const String initialRoute = NavigationWrapperView.route;

  static Map<String, Widget Function(BuildContext)> routes = {
    NavigationWrapperView.route: (context) => const NavigationWrapperView(),
    HomeView.route: (context) => const HomeView(),
    OnboardingView.route: (context) => const OnboardingView(),

    TipsView.route: (context) => const TipsView(),
    TipDetailView.route: (context) {
      final tip = ModalRoute.of(context)!.settings.arguments as TipModel;
      return TipDetailView(tip: tip);
    },

    UserSettingsView.route: (context) => const UserSettingsView(),
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
    BotAllListView.route: (context) => const BotAllListView(),
    BotHomeView.route: (context) => const BotHomeView(),

  };

}