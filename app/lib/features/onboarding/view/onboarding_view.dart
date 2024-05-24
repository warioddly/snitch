import 'package:flutter/material.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';


class OnboardingView extends StatefulWidget {

  const OnboardingView({super.key});

  static const String route = '/onboarding';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContentBox(
        child: Placeholder(),
      ),
    );
  }
}