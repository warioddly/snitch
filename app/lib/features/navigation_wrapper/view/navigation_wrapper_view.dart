import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/view/bot_home_view.dart';
import 'package:snitch/features/home/bloc/navigation_bar_bloc.dart';
import 'package:snitch/features/home/view/home_view.dart';
import 'package:snitch/features/navigation_wrapper/widgets/bottom_navigation.dart';
import 'package:snitch/features/profile/view/profile_settings_view.dart';
import 'package:snitch/features/tips/view/tips_view.dart';


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
    ('Profile', const ProfileSettingsView(), CupertinoIcons.person),
  ];

  final bloc = NavigationBarBloc();
  final pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<NavigationBarBloc, int>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: BottomNavigation(
                items: items,
                index: state,
                onTap: (index) {

                  if (index == bloc.state) {
                    return;
                  }

                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );

                  bloc.add(NavigationBarChanged(index));
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
    );
  }
}