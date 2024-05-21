import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/bot/bloc/bot_bloc/bot_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';

class BotDeleteAlertDialog extends StatelessWidget {

  const BotDeleteAlertDialog({super.key, required this.bot});

  final BotModel bot;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        "Delete Bot",
        style: theme.textTheme.headlineMedium,
      ),
      content: Text(
        "Are you sure you want to delete ${bot.name}?",
        style: theme.textTheme.bodyMedium
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<BotBloc>().add(BotDeleteEvent(bot.id!));
            Navigator.of(context).maybePop(true);
          },
          child: const Text(
            "Delete",
          ),
        ),
      ],
    );
  }

}