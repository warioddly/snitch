import 'package:flutter/material.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/shared/ui/images/logo.dart';

class TipCategoryEmptyWidget extends StatelessWidget {

  const TipCategoryEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Logo(),

          Text(
            APP_NAME.toUpperCase(),
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "This category is empty",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6F6F6F)
            ),
          ),

        ],
      ),
    );
  }

}