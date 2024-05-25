import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/widgets/bot_delete_alert_dialog.dart';
import 'package:snitch/features/bot/widgets/bot_mini_info_card.dart';
import 'package:snitch/features/wrapper/view/wrapper_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/list/menu_list_tile.dart';

class BotSettingsView extends StatelessWidget {

  const BotSettingsView({super.key, required this.bot});

  static const String route = '/bot-settings';

  final BotModel bot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Bot Settings',
        enableImplyLeading: true,
      ),
      body: ContentBox(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [

            BotMiniInfoCard(bot: bot),

            const SizedBox(height: 20),

            ...[
              MenuListTileItem(
                title: 'Preferences',
                subtitle: "Change bot's preferences",
                icon: CupertinoIcons.gear_alt,
                onTap: () => debugPrint('Preferences'),
              ),
              MenuListTileItem(
                title: 'Information & Stats',
                subtitle: "View bot's information and statistics",
                icon: CupertinoIcons.info,
                onTap: () => debugPrint('Information'),
              ),
              MenuListTileItem(
                  title: 'Delete Bot',
                  icon: CupertinoIcons.delete,
                  onTap: () async {

                    if (bot.id == null) {
                      BotToast.showSimpleNotification(
                        title: "Bot does not exist",
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    
                    await showDialog<bool?>(
                      context: context,
                      builder: (context) => BotDeleteAlertDialog(bot: bot)
                    ).then((bool? success) {

                      if (success == null || !success) return;

                      BotToast.showSimpleNotification(
                        title: "Bot ${bot.name} Deleted",
                        duration: const Duration(seconds: 3),
                        crossPage: true,
                      );

                      context.read<BotsBloc>().add(const BotsReadEvent());

                      Navigator.popUntil(context, (route) => route.settings.name == WrapperView.route);

                    });


                  },
                  type: MenuListTileType.ERROR,
                  enableTrailing: false
              ),
            ].map((item) => MenuListTile(item: item)),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${BOT_APP_NAME.toUpperCase()} v1.0.0",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )

          ],
        ),
      )
    );
  }
}