import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/features/bot/bloc/bot_bloc.dart';
import 'package:snitch/features/bot/widgets/bot_list_card.dart';
import 'package:snitch/features/home/widgets/empty_home_page.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';


class HomeView extends StatefulWidget {

  const HomeView({super.key});

  static const String route = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  final botBloc = GetIt.I.get<BotBloc>();


  @override
  void initState() {
    super.initState();
    botBloc.add(const BotReadAllEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Home",
      ),
      body: ContentBox(
        child: Column(
          children: [
            Flexible(
              child: BlocBuilder(
                bloc: botBloc,
                builder: (context, state) {

                  if (state is BotListEmpty) {
                    return const EmptyHomePage();
                  }

                  if (state is BotAllLoaded) {
                    return ListView(
                      shrinkWrap: true,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Bots",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),

                        ...state.bots.map((bot) => BotListCard(bot: bot))

                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}