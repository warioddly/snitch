import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/user/widgets/user_config_wrapper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:snitch/features/onboarding/views/onboarding_view.dart';
import 'package:snitch/features/wrapper/bloc/navigation_bar/navigation_bar_bloc.dart';
import 'package:snitch/features/wrapper/models/bottom_navigation_item.dart';
import 'package:snitch/features/wrapper/widgets/bottom_navigation.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/home/views/home_view.dart';
import 'package:snitch/features/user/views/user_settings_view.dart';
import 'package:snitch/features/tips/views/tips_view.dart';
import 'package:snitch/features/bot/views/bot_home_view.dart';


class WrapperView extends StatefulWidget {

  const WrapperView({super.key});

  static const String route = '/';

  @override
  State<WrapperView> createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {


  static const List<BottomNavigationItem> _items = [
    BottomNavigationItem(label: 'Home', view: HomeView(), icon: CupertinoIcons.home),
    BottomNavigationItem(label: 'Tips', view: TipsView(), icon: CupertinoIcons.rectangle_on_rectangle_angled),
    BottomNavigationItem(label: 'History', view: BotHomeView(), icon: CupertinoIcons.timelapse),
    BottomNavigationItem(label: 'Profile', view: UserSettingsView(), icon: CupertinoIcons.person)
  ];


  final navigationBloc = NavigationBarBloc();
  final pageController = PageController(keepPage: true);


  @override
  Widget build(BuildContext context) {
    return UserConfigWrapper(
      builder: (context, state) {

        if (state is UserConfigsBad) {
          FlutterNativeSplash.remove();
          return const OnboardingView();
        }

        if (state is UserConfigsGood) {
          FlutterNativeSplash.remove();
          return Scaffold(
            bottomNavigationBar: BlocBuilder<NavigationBarBloc, int>(
              bloc: navigationBloc,
              builder: (context, state) {
                return BottomNavigation(
                  items: _items,
                  index: state,
                  onTap: (index) {

                    if (index == state) {
                      return;
                    }

                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );

                    navigationBloc.add(NavigationBarChanged(index));
                  },
                );
              },
            ),
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _items.map((item) => item.view).toList(),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}