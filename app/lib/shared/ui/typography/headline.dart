
import 'package:flutter/material.dart';

class Headline extends StatelessWidget {

  const Headline({super.key, required this.text, this.rightText, this.onTapRightText});

  final String text;
  final String? rightText;
  final Function()? onTapRightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),


          if (rightText != null)
            GestureDetector(
              onTap: onTapRightText,
              child: Row(
                children: [

                  Text(
                    rightText!,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(width: 5),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  )

                ],
              )
            )


        ],
      )
    );
  }
}
