import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/commands/widgets/commands_bottom_sheet.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';

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
            child: TextField(
              autofocus: false,
                controller: textController,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Send a command',
                  hintStyle: const TextStyle(
                      color: Color(0xFFA3A3A8),
                      fontWeight: FontWeight.w400
                  ),
                  filled: true,
                  fillColor: const Color(0xFF232627),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2D2F32)),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2D2F32)),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  suffixIcon: IconButton(
                    tooltip: "Send",
                    icon: const Icon(CupertinoIcons.paperplane),
                    color: const Color(0xFFA3A3A8),
                    onPressed: () {
                      textController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFA3A3A8),
                  fontWeight: FontWeight.w400,
                )
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
