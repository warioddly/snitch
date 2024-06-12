import 'package:flutter/material.dart';

import 'package:snitch/core/utils/extensions/build_context_extenstion.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/models/bot_model.dart';

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
          onPressed: context.goBack,
          child: const Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () {
            getIt<BotActionBloc>().add(BotActionDeleteEvent(id: bot.id!));
            context.goBack(true);
          },
          child: const Text(
            "Delete",
          ),
        ),
      ],
    );
  }

}