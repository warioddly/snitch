


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/features/tips/model/tip_model.dart';

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

          showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(tip.title),
                  content: Text(tip.description),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
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
