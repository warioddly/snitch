import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/widgets/tip_list_tile.dart';

class TipSuggestionList extends StatelessWidget {

  const TipSuggestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tips.getRange(0, tips.length >= 5 ? 5 : tips.length).map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TipListTile(tip: e),
        );
      }).toList(),
    );
  }
}
