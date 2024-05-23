

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot_bloc.dart';

class UserBotWrapper extends StatefulWidget {
  const UserBotWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<UserBotWrapper> createState() => _UserBotWrapperState();
}

class _UserBotWrapperState extends State<UserBotWrapper> {


  UserBotBloc get bloc => context.read<UserBotBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(UserBotStarted());
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBotBloc, UserBotState>(
      listener: (context, state) {

        if (state is UserBotPingMessageReceivedState) {
          BotToast.showSimpleNotification(
            title: '${state.message.bot.name} online',
            subTitle: 'Ping message received! 🚀',
          );
        }

      },
      child: widget.child,
    );
  }
}
