import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/core/utils/extensions/build_context_extenstion.dart';
import 'package:snitch/features/tips/model/tip_model.dart';
import 'package:snitch/features/tips/views/tip_detail_view.dart';

class TipListCard extends StatelessWidget {

  const TipListCard({super.key, required this.tip});

  final TipModel tip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 129,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF232627),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.go(TipDetailView.route, arguments: tip),
          child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  Icon(
                    tip.icon,
                    size: 28,
                  ),

                  Text(
                      tip.title.split(" ").first,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      )
                  ),

                  Text(
                    tip.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w200,
                      overflow: TextOverflow.ellipsis
                    ),
                    maxLines: 2,
                  ),

                  const SizedBox(height: 11),

                  const Icon(
                    CupertinoIcons.chevron_right_circle_fill,
                    size: 36,
                  ),

                ],
              )
          ),
        ),
      ),
    );
  }
}
