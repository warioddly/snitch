import 'package:flutter/material.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/features/tips/widgets/tip_console_suggestion_list.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';

class ConsoleEmptyChat extends StatefulWidget {

  const ConsoleEmptyChat({super.key});

  @override
  State<ConsoleEmptyChat> createState() => _ConsoleEmptyChatState();
}

class _ConsoleEmptyChatState extends State<ConsoleEmptyChat> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ContentBox(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              APP_NAME.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: const Color(0xFFA3A3A8),
                fontWeight: FontWeight.w700
              )
            ),

            const SizedBox(height: 40),

            const TipConsoleSuggestionList()

          ],
        ),
      ),
    );
  }
}
