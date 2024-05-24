import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivityCheckerWidget extends StatefulWidget {
  const InternetConnectivityCheckerWidget({super.key, required this.child});

  final Widget child;

  @override
  State<InternetConnectivityCheckerWidget> createState() => _InternetConnectivityCheckerWidgetState();
}

class _InternetConnectivityCheckerWidgetState extends State<InternetConnectivityCheckerWidget> {


  late final StreamSubscription<InternetStatus> internetConnectionListener;
  bool initialized = false;


  @override
  void initState() {
    super.initState();
    internetConnectionListener = InternetConnection().onStatusChange.listen(_onStatusChange);
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  void _onStatusChange(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        if (!initialized) {
          initialized = true;
          return;
        }
        BotToast.showSimpleNotification(
          title: 'Internet Connected',
          subTitle: 'You are now connected to the internet',
          crossPage: true,
          backgroundColor: Colors.green,
        );
        break;
      case InternetStatus.disconnected:
        BotToast.showSimpleNotification(
          title: 'Disconnected',
          subTitle: 'You are now disconnected from the internet',
          crossPage: true,
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.red,
        );
        break;
    }
  }


  @override
  void dispose() {
    internetConnectionListener.cancel();
    super.dispose();
  }

}
