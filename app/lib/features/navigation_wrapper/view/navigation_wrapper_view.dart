import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:snitch/features/bot/view/bot_home_view.dart';
import 'package:snitch/features/navigation_wrapper/bloc/navigation_bar_bloc.dart';
import 'package:snitch/features/home/view/home_view.dart';
import 'package:snitch/features/navigation_wrapper/widgets/bottom_navigation.dart';
import 'package:snitch/features/onboarding/view/onboarding_view.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/view/user_settings_view.dart';
import 'package:snitch/features/tips/view/tips_view.dart';
import 'package:snitch/features/user/widgets/user_bot_wrapper.dart';


class NavigationWrapperView extends StatefulWidget {

  const NavigationWrapperView({super.key});

  static const String route = '/';

  @override
  State<NavigationWrapperView> createState() => _NavigationWrapperViewState();
}

class _NavigationWrapperViewState extends State<NavigationWrapperView> {


  final List<BottomNavigationItem> items = [
    ('Home', const HomeView(), CupertinoIcons.home),
    ('Tips', const TipsView(), CupertinoIcons.rectangle_on_rectangle_angled),
    ('History', const BotHomeView(), CupertinoIcons.timelapse),
    ('Profile', const UserSettingsView(), CupertinoIcons.person),
  ];


  late final UserBloc userBloc;
  final navigationBloc = NavigationBarBloc();
  final pageController = PageController(keepPage: true);


  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context)..add(const UserCheckConfig());
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, state) {

        if (state is UserConfigsBad) {
          FlutterNativeSplash.remove();
          return const OnboardingView();
        }

        if (state is UserConfigsGood) {
          FlutterNativeSplash.remove();
          return UserBotWrapper(
            child: BlocProvider(
              create: (_) => navigationBloc,
              child: BlocBuilder<NavigationBarBloc, int>(
                builder: (context, state) {
                  return SafeArea(
                    child: Scaffold(
                      bottomNavigationBar: BottomNavigation(
                        items: items,
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
                                  children: items.map((item) => item.$2).toList(),
                                )
                            ),
                          ]
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );

      },
    );
  }
}