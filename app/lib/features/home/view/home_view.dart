import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/extensions/build_context_extenstion.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/view/bot_all_list_view.dart';
import 'package:snitch/features/bot/widgets/bot_appbar_create_button.dart';
import 'package:snitch/features/bot/widgets/bot_list_context_menu_wrapper_card.dart';
import 'package:snitch/features/home/widgets/empty_home_page.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/typography/headline.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  static const String route = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Home",
        actions: [BotAppbarCreateButton()],
      ),
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
                            context.go(BotAllListView.route);
                          },
                        ),

                        ...state.bots.map((bot) => BotListContextMenuWrapperCard(bot: bot))

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