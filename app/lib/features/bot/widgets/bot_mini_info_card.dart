import 'package:flutter/material.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/core/utils/date_utils.dart' as du;

class BotMiniInfoCard extends StatelessWidget {

  const BotMiniInfoCard({super.key, required this.bot});

  final BotModel bot;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            bot.image!,
            width: 106,
            height: 106,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 12),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              bot.name,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
              maxLines: 1,
            ),

            const SizedBox(height: 5),

            Text(
              'Last seen ${du.DateUtils.timeAgoSinceDate(DateTime.now().subtract(const Duration(minutes: 5)))}',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary),
            ),

          ],
        ),

      ],
    );
  }

}