import 'package:flutter/material.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/features/home/widgets/empty_home_page.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';


class HomeView extends StatelessWidget {

  const HomeView({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Home",
      ),
      body: ContentBox(
        child: Column(
          children: [

            Expanded(
              child: false
                  ? const EmptyHomePage()
                  : ListView(
                      shrinkWrap: true,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Bots",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),

                  ...BotFaker.createBots(15).map((bot) => BotListCard(bot: bot))

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}