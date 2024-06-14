import 'package:flutter/material.dart';
import 'package:snitch/features/bot/models/bot_model.dart';
import 'package:snitch/features/bot/views/bot_all_list_view.dart';
import 'package:snitch/features/bot/views/bot_create_view.dart';
import 'package:snitch/features/bot/views/bot_edit_view.dart';
import 'package:snitch/features/bot/views/bot_home_view.dart';
import 'package:snitch/features/bot/views/bot_settings_view.dart';
import 'package:snitch/features/commands/views/command_view.dart';
import 'package:snitch/features/home/views/home_view.dart';
import 'package:snitch/features/user/views/user_bot_edit_view.dart';
import 'package:snitch/features/wrapper/views/wrapper_view.dart';
import 'package:snitch/features/console/views/console_view.dart';
import 'package:snitch/features/onboarding/views/onboarding_view.dart';
import 'package:snitch/features/tips/views/tips_category_view.dart';
import 'package:snitch/features/user/views/user_settings_view.dart';
import 'package:snitch/features/user/views/user_theme_settings_view.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/views/tip_detail_view.dart';
import 'package:snitch/features/tips/views/tips_view.dart';


class AppRoutes {

  static const String initialRoute = WrapperView.route;

  static Map<String, Widget Function(BuildContext)> routes = {
    
    WrapperView.route: (context) => const WrapperView(),
    HomeView.route: (context) => const HomeView(),
    OnboardingView.route: (context) => const OnboardingView(),
    CommandView.route: (context) => const CommandView(),

    TipsView.route: (context) => const TipsView(),
    TipsCategoryView.route: (context) {
      final category = ModalRoute.of(context)!.settings.arguments as TipCategory;
      return TipsCategoryView(category: category);
    },
    TipDetailView.route: (context) {
      final tip = ModalRoute.of(context)!.settings.arguments as TipModel;
      return TipDetailView(tip: tip);
    },

    UserSettingsView.route: (context) => const UserSettingsView(),
    UserBotUpdateSettingView.route: (context) => const UserBotUpdateSettingView(),
    UserThemeSettingsView.route: (context) => const UserThemeSettingsView(),

    ConsoleView.route: (context) {
      final bot = ModalRoute.of(context)!.settings.arguments as BotModel;
      return ConsoleView(bot: bot);
    },

    BotSettingsView.route: (context) {
      final bot = ModalRoute.of(context)!.settings.arguments as BotModel;
      return BotSettingsView(bot: bot);
    },
    BotEditView.route: (context) {
      final bot = ModalRoute.of(context)!.settings.arguments as BotModel;
      return BotEditView(bot: bot);
    },
    BotCreateView.route: (context) => const BotCreateView(),
    BotAllListView.route: (context) => const BotAllListView(),
    BotHomeView.route: (context) => const BotHomeView(),

  };

}