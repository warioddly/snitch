import 'package:flutter/material.dart';
import 'package:snitch/core/extensions/string_extension.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/widgets/tip_category_empty_widget.dart';
import 'package:snitch/features/tips/widgets/tip_list_tile.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/sliver_content_box.dart';


class TipsCategoryView extends StatefulWidget {
  const TipsCategoryView({super.key, required this.category});

  static const String route = '/tips-category-view';

  final TipCategory category;

  @override
  State<TipsCategoryView> createState() => _TipsCategoryViewState();
}

class _TipsCategoryViewState extends State<TipsCategoryView> {


  @override
  Widget build(BuildContext context) {

    final filteredTips = <TipModel>[];

    filteredTips.addAll(tips.where((tip) => tip.category == widget.category));

    return Scaffold(
      body: CustomScrollView(
        slivers: [


          SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Appbar(
              enableImplyLeading: true,
              title: "${widget.category.name.toCapitalize()} category",
            ),
          ),

          SliverContentBox(
            child: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ...filteredTips.map((tip) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TipListTile(tip: tip),
                    );
                  }),

                  if (filteredTips.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: const TipCategoryEmptyWidget(),
                    )

                ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}
