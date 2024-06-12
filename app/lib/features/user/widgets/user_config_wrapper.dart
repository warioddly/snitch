import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/features/user/bloc/user_config/user_config_bloc.dart';


class UserConfigWrapper extends StatefulWidget {
  const UserConfigWrapper({super.key, required this.builder});

  final BlocWidgetBuilder<UserState> builder;

  @override
  State<UserConfigWrapper> createState() => _UserConfigWrapperState();
}

class _UserConfigWrapperState extends State<UserConfigWrapper> {

  UserBotBloc get botBloc  => context.read<UserBotBloc>();
  UserBloc    get userBloc => context.read<UserBloc>();

  final configBloc = getIt<UserConfigBloc>();


  @override
  void initState() {
    super.initState();
    configBloc.add(UserConfigReadEvent());
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [

        BlocListener<UserConfigBloc, UserConfigState>(
          bloc: configBloc,
          listener: (context, state) {

            if (state is UserConfigReaded) {
              botBloc.add(UserBotStartEvent(state.configs));
            }

            if (state is UserConfigEmpty) {
              userBloc.add(const UserBad());
            }

            if (state is UserConfigError) {
              BotToast.showSimpleNotification(
                  title: 'Oops! Something went wrong 😢',
                  subTitle: 'Please check your internet connection and try again.'
              );
            }

          },
        ),

        BlocListener<UserBotBloc, UserBotState>(
          listener: (context, state) {

            if (state is UserBotPingMessageReceived) {
              BotToast.showSimpleNotification(
                title: '${state.message.bot.name} online',
                subTitle: 'Ping message received! 🚀',
              );
            }

            if (state is UserBotStarted) {
              userBloc.add(const UserGood());
            }

          },
        ),

      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: widget.builder,
      ),
    );
  }

}
