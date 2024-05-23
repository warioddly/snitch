import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_settings_view.dart';
import 'package:snitch/features/console/bloc/console_bloc.dart';
import 'package:snitch/features/console/faker/console_message_faker.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/console/widgets/console_chat_footer.dart';
import 'package:snitch/features/console/widgets/console_message_box.dart';
import 'package:snitch/features/user/bloc/user_bot_bloc.dart';
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

          if (state is UserBotMessageReceivedState) {
            // BotToast.showSimpleNotification(
            //   title: 'Message received',
            //   subTitle: '${state.message.bot.name} online',
            // );
            messages.add(state.message);

          }

          if (state is UserBotMessageSentState) {
            messages.add(state.message);
          }

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );

        },
        builder: (context, state) {

          return CustomScrollView(
            shrinkWrap: false,
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
                    return ConsoleMessageBox(message: messages[index]);
                  },
                  childCount: messages.length,
                ),
              ),

              // Stack(
              //   children: <Widget>[
              //     GestureDetector(
              //         onPanDown: (_) => FocusScope.of(context).unfocus(),
              //         child: ListView(
              //           reverse: true,
              //           shrinkWrap: true,
              //           children: true
              //               ? messages.map((message) => ConsoleMessageBox(message: message)).toList()
              //               : const [ ConsoleEmptyChat() ],
              //         )
              //     ),
              //   ],
              // ),

            ],
          );
        },
      ),
      bottomNavigationBar: const ChatFooter(),
    );
  }


}