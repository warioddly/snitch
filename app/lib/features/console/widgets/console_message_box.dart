import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/console/widgets/console_message_box_header.dart';
import 'package:snitch/features/user/bloc/user_bot_bloc.dart';


class ConsoleMessageBox extends StatelessWidget {

  const ConsoleMessageBox({super.key, required this.message});

  final ConsoleMessageModel message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userBotBloc = context.read<UserBotBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 35),
      decoration: BoxDecoration(
        color: message.user.id == userBotBloc.user?.id ? Colors.transparent : theme.colorScheme.secondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ConsoleMessageBoxHeader(message: message),

          SelectableText(
            message.content,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w400
            )
          )

        ],
      ),
    );
  }
}
