import 'package:flutter/material.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  static const String route = '/tips';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Appbar(
        title: "Tips",
      ),
      body: ContentBox(
        child: Placeholder(),
      ),
    );
  }
}
