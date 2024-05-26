import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetConnectivityCheckerWidget extends StatefulWidget {
  const InternetConnectivityCheckerWidget({super.key, required this.child});

  final Widget child;

  @override
  State<InternetConnectivityCheckerWidget> createState() => _InternetConnectivityCheckerWidgetState();
}

class _InternetConnectivityCheckerWidgetState extends State<InternetConnectivityCheckerWidget> {


  final internetConnectionListener = InternetConnection().onStatusChange.asBroadcastStream();
  bool initialized = false;
  bool _visible = true;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: widget.child,
          ),

          StreamBuilder(
            stream: internetConnectionListener,
            builder: (context, AsyncSnapshot<InternetStatus> status) {

              if (initialized && status.data == InternetStatus.connected) {
                Future.delayed(const Duration(seconds: 5), () {
                  if (mounted) {
                    setState(() => _visible = false);
                  }
                });
                return Visibility(
                    maintainSize: _visible,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _visible,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Text(
                          "You are now connected to the internet",
                          style: theme.textTheme.bodySmall
                      ),
                    )
                );
              }

              if (status.data == InternetStatus.disconnected) {
                if (mounted) {
                  _visible = true;
                }
                return Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text(
                      "You are now disconnected from the internet",
                    style: theme.textTheme.bodySmall
                  ),
                );
              }

              initialized = true;

              return const SizedBox();

            }
          )

        ],
      ),
    );
  }

}
