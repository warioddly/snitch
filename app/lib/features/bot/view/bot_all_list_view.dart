import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/features/bot/bloc/bot_search_bloc/bot_search_bloc.dart';
import 'package:snitch/features/bot/widgets/bot_empty_widget.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/sliver_content_box.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';

class BotAllListView extends StatefulWidget {

  const BotAllListView({super.key});

  static const String route = '/bot-all-list';

  @override
  State<BotAllListView> createState() => _BotAllListViewState();
}

class _BotAllListViewState extends State<BotAllListView> {

  final bloc = GetIt.I.get<BotSearchBloc>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bloc.add(const BotSearchBotEvent(""));

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        bloc.add(const BotSearchBotEvent(""));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<BotSearchBloc>(
          create: (context) => bloc,
          child: CustomScrollView(
            shrinkWrap: false,
            slivers: [

              const SliverAppBar(
                pinned: false,
                floating: true,
                stretch: false,
                snap: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Appbar(
                  title: 'Search Bots',
                  enableImplyLeading: true,
                ),
              ),

              SliverContentBox(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 7),
                child: SliverAppBar(
                  pinned: false,
                  floating: true,
                  stretch: false,
                  snap: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: StyledTextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Bots',
                      suffixIcon: IconButton(
                        enableFeedback: true,
                        tooltip: "Search",
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(CupertinoIcons.search),
                        color: const Color(0xFFA3A3A8),
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          if (_searchController.text.isNotEmpty) {
                            bloc.add(BotSearchBotEvent(_searchController.text));
                          }

                        },
                      ),
                    ),
                  ),
                ),
              ),

              SliverContentBox(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BlocBuilder<BotSearchBloc, BotSearchState>(
                  builder: (context, state) {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                          [

                            if (state is BotSearchError)
                              Text(state.message),

                            if (state is BotSearchBots)
                              ...state.bots.map((bot) => BotListCard(bot: bot)),

                            if (state is BotSearchEmpty)
                              const BotEmptyWidget(),

                          ]
                      ),
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

}