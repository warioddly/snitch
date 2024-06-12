import 'package:flutter/cupertino.dart';
import 'package:snitch/core/extensions/build_context_extenstion.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/view/bot_edit_view.dart';
import 'package:snitch/features/bot/widgets/bot_list_tile.dart';

class BotListContextMenuWrapperCard extends StatelessWidget {

  const BotListContextMenuWrapperCard({super.key, required this.bot});

  final BotModel bot;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: CupertinoContextMenu.builder(
        enableHapticFeedback: true,
        actions: [

          CupertinoContextMenuAction(
            child: const Text('Edit'),
            onPressed: () => context.go(BotEditView.route, arguments: bot),
          ),

          CupertinoContextMenuAction(
            child: const Text('Delete'),
            onPressed: () => throw UnimplementedError(),
          ),

        ],
        builder: (BuildContext context, Animation<double> animation) => BotListTile(bot: bot),
      ),
    );
  }

}