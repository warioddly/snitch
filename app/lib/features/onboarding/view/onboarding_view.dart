import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/view/bot_all_list_view.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/features/home/widgets/empty_home_page.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/typography/headline.dart';

class OnboardingView extends StatefulWidget {

  const OnboardingView({super.key});

  static const String route = '/onboarding';

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentBox(
        child: Column(
          children: [
            Flexible(
              child: BlocBuilder(
                bloc: context.read<BotsBloc>()..add(const BotsReadEvent()),
                builder: (context, state) {

                  if (state is BotsEmpty) {
                    return const EmptyHomePage();
                  }

                  if (state is BotsLoaded) {
                    return ListView(
                      shrinkWrap: false,
                      children: [

                        Headline(
                          text: "Bots",
                          rightText: "View all bots",
                          onTapRightText: () {
                            debugPrint("View all bots");
                            Navigator.pushNamed(context, BotAllListView.route);
                          },
                        ),

                        ...state.bots.map((bot) => BotListCard(bot: bot))

                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}