import 'package:flutter/material.dart';
import 'package:snitch/features/tips/model/tip_model.dart';

class TipCategoriesChipFilter extends StatelessWidget {

  const TipCategoriesChipFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        for (final category in [...TipCategory.values, ...TipCategory.values])
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Chip(
              visualDensity: VisualDensity.compact,
              label: Text(category.name),
              backgroundColor: const Color(0xFF232627),
            ),
          )
      ],
    );
  }
}
