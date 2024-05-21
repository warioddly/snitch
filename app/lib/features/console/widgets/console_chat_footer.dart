import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/commands/widgets/commands_bottom_sheet.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/StyledTextField.dart';

class ChatFooter extends StatefulWidget {

  const ChatFooter({super.key});

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      child: Row(
        children: [

          Flexible(
            child: StyledTextField(
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
                      textController.clear();
                      FocusScope.of(context).unfocus();
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
