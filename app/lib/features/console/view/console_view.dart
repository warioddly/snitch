import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_settings_view.dart';
import 'package:snitch/features/console/bloc/console_bloc.dart';
import 'package:snitch/features/console/faker/console_message_faker.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/console/widgets/console_chat_footer.dart';
import 'package:snitch/features/console/widgets/console_message_box.dart';
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

  late final ConsoleBloc bloc;

  final List<ConsoleMessageModel> messages = ConsoleMessageFaker.createMessages(15);


  @override
  void initState() {
    super.initState();
    bloc = ConsoleBloc(bot: bot)..add(ConsoleStarted());
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
      body: CustomScrollView(
        shrinkWrap: false,
        slivers: [

          const SliverAppBar(
            snap: true,
            floating: true,
            pinned: false,
            automaticallyImplyLeading: false,
            flexibleSpace: ChatFooter(),
          ),


          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
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



          // SliverAppBar(
          //   snap: false,
          //   floating: true,
          //   pinned: true,
          //   automaticallyImplyLeading: false,
          //   flexibleSpace: const ChatFooter(),
          // )


        ],
      ),
      bottomNavigationBar: const ChatFooter(),
    );
  }


}