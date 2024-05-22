import 'package:flutter/material.dart';
import 'package:snitch/core/constants/constants.dart';

class BotConveyInfo extends StatelessWidget {
  const BotConveyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "${BOT_APP_NAME.toUpperCase()} v1.0.0",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
