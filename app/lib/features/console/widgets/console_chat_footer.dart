import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/commands/widgets/commands_bottom_sheet.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/shared/ui/textfield/bordered_text_field.dart';

class ChatFooter extends StatefulWidget {

  const ChatFooter({super.key});

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<UserBotBloc>();

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      child: Row(
        children: [

          Flexible(
            child: BorderedTextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Send a command',
                  suffixIconConstraints: const BoxConstraints(
                    maxWidth: 42,
                    maxHeight: 42,
                  ),
                  suffixIcon: IconButton(
                    visualDensity: VisualDensity.compact,
                    tooltip: "Send",
                    icon: const Icon(CupertinoIcons.paperplane),
                    color: const Color(0xFFA3A3A8),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      bloc.add(UserBotMessageSendEvent(textController.text));
                      textController.clear();
                    },
                  ),
                ),
            ),
          ),

          IconButton(
            tooltip: 'Commands',
            onPressed: () {

              FocusScope.of(context).unfocus();

              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                useRootNavigator: true,
                isDismissible: false,
                enableDrag: true,
                builder: (context) => const CommandsBottomSheet(),
              );

            },
            icon: const Icon(CupertinoIcons.layers_alt),
          ),

        ],
      ),
    );
  }
}
