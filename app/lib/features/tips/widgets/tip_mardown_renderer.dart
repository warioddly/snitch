import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TipMarkdownRenderer extends StatelessWidget {

  const TipMarkdownRenderer({super.key, required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    return Markdown(
        padding: const EdgeInsets.all(25),
        data: source,
        selectable: true,
        imageDirectory: "/assets/images",
        imageBuilder: (Uri uri, String? title, String? alt) {
          return Image.asset(
            uri.path,
          );
        },
        onTapLink: (text, href, title) async {

          try {
            if (href != null && !await canLaunchUrlString(href)) {
              throw 'Could not launch $title';
            }

            await launchUrlString(href!);
          }
          catch (e) {
            BotToast.showSimpleNotification(
              title: "Could not launch $title",
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            );
          }

        }
    );
  }
}
