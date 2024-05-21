import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:flutter/services.dart';
import 'package:snitch/shared/ui/images/logo.dart';

class ConsoleMessageBoxHeader extends StatelessWidget {

  const ConsoleMessageBoxHeader({super.key, required this.message});

  final ConsoleMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const Logo(
            width: 31,
          ),
        ),


        IconButton(
          icon: const Icon(CupertinoIcons.doc_on_doc, size: 15),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: message.content));
            BotToast.showSimpleNotification(
              title: 'Copied to clipboard',
              duration: const Duration(seconds: 2),
            );
          },
        )

      ],
    );
  }
}
