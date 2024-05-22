import 'package:flutter/material.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/features/tips/widgets/tip_categories_chip_filter.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/sliver_content_box.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  static const String route = '/tips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          const SliverContentBox(
            child: SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Appbar(
                title: "Tips",
              ),
            ),
          ),

          const SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Flexible(
                child: TipCategoriesChipFilter()
            ),
          ),

          SliverContentBox(
            child: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ...tips.map((e) => ListTile(
                    title: Text(e.title),
                    onTap: () {
                      Navigator.pushNamed(context, TipDetailView.route, arguments: e);
                    },
                  ))
                ]
              ),
            ),
          )

        ],
      ),
    );
  }
}
