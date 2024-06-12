import 'package:flutter/material.dart';
import 'package:snitch/core/extensions/build_context_extenstion.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/core/utils/date_utils.dart' as du;
import 'package:snitch/features/console/view/console_view.dart';
import 'package:snitch/shared/ui/images/asset.dart';

class BotListTile extends StatelessWidget {

  const BotListTile({super.key, required this.bot});

  final BotModel bot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      enableFeedback: true,
      title: Text(
        bot.name,
        style: theme.listTileTheme.titleTextStyle,
      ),
      subtitle: Text(
        du.DateUtils.humanize(bot.updatedAt),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Asset(
          bot.image!,
          width: 41,
          height: 44,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () => context.go(ConsoleView.route, arguments: bot),
    );
  }

}