import 'package:flutter/material.dart';
import 'package:snitch/features/onboarding/model/onboard_template_model.dart';
import 'package:snitch/features/onboarding/widgets/onboard_page_template.dart';
import 'package:snitch/features/onboarding/widgets/onboard_page_views.dart';
import 'package:snitch/features/user/widgets/user_bot_create_onboard.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';


class OnboardingView extends StatefulWidget {

  const OnboardingView({super.key});

  static const String route = '/onboarding';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {

  static const int _lastPage = 2;

  final pageController = PageController(keepPage: true);

  bool isLastPage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        actions: [
          if (!isLastPage)
            TextButton(
              onPressed: () => _jumpToPage(_lastPage),
              child: const Text('Skip')
            )
        ],
      ),
      body: OnboardPageViews(
          controller: pageController,
          physics: isLastPage ? const NeverScrollableScrollPhysics() : null,
          onPageChanged: (index) {
            if (index == _lastPage) {
              setState(() {
                isLastPage = true;
              });
            }
          },
          children:  [

            OnboardPageTemplate(
                template: OnboardTemplateModel(
                    title: 'Unlock the Power Of Snitch',
                    description: 'Chat with Chat with the smartest Snitch Experience smartest Snitch Experience',
                    image: 'assets/images/logo.png',
                    button: StyledTextButton(
                        onPressed: () => _jumpToPage(1),
                        text: 'Get Started'
                    )
                )
            ),
            OnboardPageTemplate(
                template: OnboardTemplateModel(
                    title: 'Chat With Your PC',
                    description: 'Boost your mind power with Snitch',
                    image: 'assets/images/logo.png',
                    button: StyledTextButton(
                      onPressed: () => _jumpToPage(2),
                      text: 'Next',
                    )
                )
            ),
            OnboardPageTemplate(
                template: OnboardTemplateModel(
                    title: 'Boost Your Mind Power',
                    description: 'Boost your mind power with Snitch',
                    image: 'assets/images/logo.png',
                    button: StyledTextButton(
                      onPressed: () => _jumpToPage(3),
                      text: 'Let\'s Create Bot',
                    )
                )
            ),

            const UserBotCreateOnboard(),

          ]
      ),
    );
  }


  void _jumpToPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate
    );

    if (_lastPage == index) {
      setState(() {
        isLastPage = true;
      });
    }

  }

}