import 'package:flutter/material.dart';
import 'package:snitch/core/extensions/build_context_extenstion.dart';
import 'package:snitch/core/extensions/string_extension.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tips_category_view.dart';
import 'package:snitch/features/tips/widgets/tip_card.dart';
import 'package:snitch/features/tips/widgets/tip_categories_filter_chip.dart';
import 'package:snitch/features/tips/widgets/tip_category_empty_widget.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/layout/sliver_content_box.dart';
import 'package:snitch/shared/ui/typography/headline.dart';

class TipsView extends StatefulWidget {
  const TipsView({super.key});

  static const String route = '/tips';

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> {

  TipCategory? selected;

  @override
  Widget build(BuildContext context) {

    final filteredCategories = <TipCategory>[];

    if (selected != null) {
      filteredCategories.addAll(TipCategory.values.where((category) => category == selected));
    }
    else {
      filteredCategories.addAll(TipCategory.values);
    }

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

          SliverAppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: TipCategoriesFilterChip(
              selected: selected,
              onTap: (category) {
                selected = selected == category ? null : category;
                setState(() { });
              },
            )
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                ...filteredCategories.map((category) {
                  final filteredTips = <TipModel>[];

                  if (selected != null) {
                    filteredTips.addAll(tips.where((tip) => tip.category == selected));
                  }
                  else {
                    filteredTips.addAll(tips.where((tip) => tip.category == category));
                  }

                  if (selected != null && filteredTips.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const TipCategoryEmptyWidget(),
                    );
                  }

                  if (selected == null && filteredTips.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  /// TODO: Implement show first 5 tips

                  return Column(
                      children: [

                        ContentBox(
                          child: Headline(
                              text: category.name.toCapitalize(),
                              rightText: 'View all',
                              onTapRightText: () => context.go(TipsCategoryView.route, arguments: category),
                          ),
                        ),

                        Container(
                            constraints: const BoxConstraints(
                              maxHeight: 187,
                            ),
                            alignment: Alignment.centerLeft,
                            child: ListView.separated(
                              padding: const ContentBox(child: SizedBox()).padding,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return TipListCard(tip: filteredTips[index]);
                              },
                              itemCount: filteredTips.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(width: 16);
                              },
                            )
                        )

                      ]
                  );
                }),
              ]
            ),
          ),

        ],
      ),
    );
  }
}
