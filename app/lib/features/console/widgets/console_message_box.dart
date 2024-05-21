import 'package:flutter/material.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/console/widgets/console_message_box_header.dart';

class ConsoleMessageBox extends StatelessWidget {

  const ConsoleMessageBox({super.key, required this.message});

  final ConsoleMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 35),
      decoration: BoxDecoration(
        color: message.user ? Colors.transparent : const Color(0xFF232627),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ConsoleMessageBoxHeader(message: message),

          SelectableText(
            message.content,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFA0A0A5),
              fontWeight: FontWeight.w400
            )
          )

        ],
      ),
    );
  }
}
