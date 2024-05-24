import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/core/utils/date_utils.dart' as du;

class BotListCard extends StatelessWidget {

  const BotListCard({super.key, required this.bot});

  final BotModel bot;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Material(
        child: CupertinoContextMenu.builder(
          enableHapticFeedback: true,
          actions: [

            CupertinoContextMenuAction(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pushNamed('/edit', arguments: bot);
              },
            ),

            CupertinoContextMenuAction(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pushNamed('/delete', arguments: bot);
              },
            ),

          ],
          builder: (BuildContext context, Animation<double> animation) {

            // on preview open   Navigator.of(context).pushNamed('/console', arguments: bot);
            if (animation.value == 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 18),
                child: Column(
                  children: [
                    Row(
                      children: [

                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              bot.image!,
                              width: 41,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(width: 13),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                bot.name,
                                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                              ),

                              Text(
                                  du.DateUtils.humanize(bot.updatedAt),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF9E9E9E)
                                  )
                              ),

                            ],
                          ),
                        )

                      ],
                    )
                  ],
                ),
              );
            }


            return Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: theme.brightness == Brightness.dark ? const Color(0xFF232627) : const Color(0xFFE5E5E5),
                // color: const Color(0xFF232627),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/console', arguments: bot);
                },
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                bot.image!,
                                width: 41,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(width: 13),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  bot.name,
                                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                ),

                                Text(
                                    du.DateUtils.humanize(bot.updatedAt),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: const Color(0xFF9E9E9E)
                                    )
                                ),

                              ],
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}