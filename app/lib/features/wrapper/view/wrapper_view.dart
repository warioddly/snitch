import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:snitch/features/bot/view/bot_home_view.dart';
import 'package:snitch/features/wrapper/bloc/navigation_bar_bloc.dart';
import 'package:snitch/features/home/view/home_view.dart';
import 'package:snitch/features/wrapper/model/bottom_navigation_item.dart';
import 'package:snitch/features/wrapper/widgets/bottom_navigation.dart';
import 'package:snitch/features/onboarding/view/onboarding_view.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/view/user_settings_view.dart';
import 'package:snitch/features/tips/view/tips_view.dart';
import 'package:snitch/features/user/widgets/user_config_wrapper.dart';


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
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {

          if (state is UserConfigsBad) {
            FlutterNativeSplash.remove();
            return const OnboardingView();
          }

          if (state is UserConfigsGood) {
            FlutterNativeSplash.remove();
            return BlocProvider(
              create: (_) => navigationBloc,
              child: BlocBuilder<NavigationBarBloc, int>(
                builder: (context, state) {
                  return SafeArea(
                    child: Scaffold(
                      bottomNavigationBar: BottomNavigation(
                        items: _items,
                        index: state,
                        onTap: (index) {

                          if (index == navigationBloc.state) {
                            return;
                          }

                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );

                          navigationBloc.add(NavigationBarChanged(index));
                        },
                      ),
                      body: Column(
                          children: [
                            Expanded(
                                child: PageView(
                                  controller: pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: _items.map((item) => item.view).toList(),
                                )
                            ),
                          ]
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}