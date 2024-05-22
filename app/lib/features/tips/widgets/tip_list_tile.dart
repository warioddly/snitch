import 'package:flutter/material.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';

class TipListTile extends StatelessWidget {

  const TipListTile({super.key, required this.tip});

  final TipModel tip;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enableFeedback: true,
      title: Text(
          tip.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w200,
          )
      ),
      titleAlignment: ListTileTitleAlignment.center,
      onTap: () {
        Navigator.of(context).pushNamed(
          TipDetailView.route,
          arguments: tip,
        );
      },
    );
  }
}
