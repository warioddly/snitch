import 'package:flutter/material.dart';
import 'package:snitch/features/bot/view/bot_create_view.dart';

class EmptyHomePage extends StatelessWidget {

  const EmptyHomePage({super.key});


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),

          Text(
            "Welcome to Snitch",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Start chatting with ChattyAI now. You can ask me anything.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6F6F6F)
            ),
          ),

          const SizedBox(height: 10),

          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(BotCreateView.route);
            },
            child: Text(
              "Create Bot",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          )

        ],
      ),
    );
  }

}