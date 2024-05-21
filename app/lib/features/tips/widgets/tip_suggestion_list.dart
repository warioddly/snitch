import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/tips/faker/tip_faker.dart';
import 'package:snitch/features/tips/widgets/tip_list_tile.dart';

class TipSuggestionList extends StatelessWidget {

  const TipSuggestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: TipFaker.createTips(5).map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TipListTile(tip: e),
        );
      }).toList(),
    );
  }
}
