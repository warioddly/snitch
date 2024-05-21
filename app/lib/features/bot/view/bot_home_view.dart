import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/bloc/bot_bloc/bot_bloc.dart';
import 'package:snitch/features/bot/view/bot_all_list_view.dart';
import 'package:snitch/features/bot/widgets/bot_appbar_create_button.dart';
import 'package:snitch/features/bot/widgets/bot_empty_widget.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/typography/headline.dart';

class BotHomeView extends StatelessWidget {

  const BotHomeView({super.key});

  static const String route = '/bots';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'My Bots',
        actions: [BotAppbarCreateButton()],
      ),
      body: ContentBox(
        child: Column(
          children: [
            Flexible(
              child: BlocBuilder(
                bloc: context.read<BotBloc>()..add(const BotReadAllEvent()),
                builder: (context, state) {

                  if (state is BotListEmpty) {
                    return const BotEmptyWidget();
                  }

                  if (state is BotAllLoaded) {
                    return ListView(
                      shrinkWrap: false,
                      children: [

                        Headline(
                          text: "Bots",
                          rightText: "View all bots",
                          onTapRightText: () {
                            Navigator.pushNamed(context, BotAllListView.route);
                          },
                        ),

                        ...state.bots.getRange(0, state.bots.length >= 5 ? 5 : state.bots.length).map((bot) => BotListCard(bot: bot)),


                        const Headline(
                          text: "History",
                          rightText: "View all history",
                        ),

                        ...state.bots.getRange(0, state.bots.length >= 5 ? 5 : state.bots.length).map((bot) => BotListCard(bot: bot)),

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