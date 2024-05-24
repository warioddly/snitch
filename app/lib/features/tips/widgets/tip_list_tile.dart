import 'package:flutter/material.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';

class TipListTile extends StatelessWidget {

  const TipListTile({super.key, required this.tip});

  final TipModel tip;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF232627),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {

          Navigator.of(context).pushNamed(
            TipDetailView.route,
            arguments: tip,
          );

        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            tip.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w200,
            )
          ),
        ),
      ),
    );
  }
}
