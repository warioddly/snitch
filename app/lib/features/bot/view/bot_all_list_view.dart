import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/features/bot/bloc/bot_search_bloc/bot_search_bloc.dart';
import 'package:snitch/features/bot/widgets/bot_empty_widget.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/textfield/StyledTextField.dart';

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

    bloc.add(const BotSearchReadAllEvent());

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        bloc.add(const BotSearchReadAllEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Search Bots',
        enableImplyLeading: true,
      ),
      body: BlocProvider<BotSearchBloc>(
        create: (context) => bloc,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomScrollView(
            shrinkWrap: false,
            slivers: [

              SliverPadding(
                padding: const EdgeInsets.only(top: 15),
                sliver: SliverAppBar(
                  pinned: false,
                  floating: true,
                  stretch: false,
                  snap: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: StyledTextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Bots',
                      suffixIconConstraints: const BoxConstraints(
                        maxWidth: 42,
                        maxHeight: 42,
                      ),
                      suffixIcon: IconButton(
                        enableFeedback: true,
                        tooltip: "Search",
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(CupertinoIcons.search),
                        color: const Color(0xFFA3A3A8),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          bloc.add(BotSearchBotEvent(_searchController.text));
                        },
                      ),
                    ),
                  ),
                ),
              ),

              BlocBuilder<BotSearchBloc, BotSearchState>(
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