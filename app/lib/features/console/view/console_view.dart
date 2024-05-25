import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_settings_view.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/console/widgets/console_chat_footer.dart';
import 'package:snitch/features/console/widgets/console_empty_chat.dart';
import 'package:snitch/features/console/widgets/console_message_box.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';

class ConsoleView extends StatefulWidget {

  const ConsoleView({super.key, required this.bot});

  final BotModel bot;

  static const String route = '/console';

  @override
  State<StatefulWidget> createState() => _ConsoleViewState();

}

class _ConsoleViewState extends State<ConsoleView> {


  BotModel get bot => widget.bot;

  // late final ConsoleBloc bloc;

  List<ConsoleMessageModel> messages = [];

  final _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    // bloc = ConsoleBloc(bot: bot)
    //   ..add(ConsoleStarted());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: bot.name,
        enableImplyLeading: true,
        actions: [
          IconButton(
              tooltip: 'Bot settings',
              icon: const Icon(CupertinoIcons.chevron_left_slash_chevron_right),
              onPressed: () => Navigator.pushNamed(context, BotSettingsView.route, arguments: bot)
          )
        ],
      ),
      body: BlocConsumer<UserBotBloc, UserBotState>(
        listener: (context, state) {

          if (state is UserBotMessageReceived) {
            messages.add(state.message);
          }

          if (state is UserBotMessageSent) {
            messages.add(state.message);
          }

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );

        },
        builder: (context, state) {
          return Column(
            children: [

              Expanded(
                child: CustomScrollView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  slivers: [

                    /// TODO: Implement Sliver Search Bar
                    // const SliverAppBar(
                    //   snap: true,
                    //   floating: true,
                    //   pinned: false,
                    //   automaticallyImplyLeading: false,
                    //   flexibleSpace: ChatFooter(),
                    // ),


                    SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return ConsoleMessageBox(
                          key: ValueKey(messages[index].id),
                          message: messages[index],
                        );
                      },
                        childCount: messages.length,
                      ),
                    ),


                    if (messages.isEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return const ConsoleEmptyChat();
                        },
                          childCount: 1,
                        ),
                      )

                  ],
                ),
              ),

              const ChatFooter(),

            ],
          );
        },
      ),
    );
  }


}