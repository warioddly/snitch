import 'package:flutter/material.dart';
import 'package:snitch/core/extensions/string_extension.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';

class TipCategoriesFilterChip extends StatelessWidget {

  const TipCategoriesFilterChip({super.key, required this.onTap, this.selected});

  final Function(TipCategory) onTap;
  final TipCategory? selected;

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      padding: const ContentBox(child: SizedBox()).padding,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        final category = TipCategory.values[index];
        return Center(
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: category == selected ? const Color(0xFF3D3F44) : const Color(0xFF232627),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                onTap(category);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                    category.name.toCapitalize(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w200,
                    )
                ),
              ),
            ),
          ),
        );
      },
      itemCount: TipCategory.values.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 11);
      },
    );

  }
}
