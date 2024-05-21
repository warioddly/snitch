
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/bot/view/bot_create_view.dart';

class BotAppbarCreateButton extends StatelessWidget {
  const BotAppbarCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Create New Bot',
      icon: const Icon(CupertinoIcons.sparkles),
      onPressed: () {
        Navigator.of(context).pushNamed(BotCreateView.route);
      },
    );
  }
}
