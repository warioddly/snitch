import 'package:flutter/material.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/widgets/tip_mardown_renderer.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';

class TipDetailView extends StatelessWidget {

  const TipDetailView({super.key, required this.tip});

  static const String route = '/tip-detail-view';

  final TipModel tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              floating: true,
              stretch: false,
              snap: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Appbar(
                title: tip.title,
                enableImplyLeading: true,
              ),
            ),
          ];
        },
        body: TipMarkdownRenderer(
          source: tip.markdown,
        )
      )
    );
  }
}
