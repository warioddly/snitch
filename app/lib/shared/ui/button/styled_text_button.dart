import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyledTextButton extends StatelessWidget {

  const StyledTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.loading = false,
    this.tapWhenLoading = false,
  });

  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final bool tapWhenLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (loading && !tapWhenLoading) {
            return;
          }
          onPressed.call();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFF1B1E20)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(text),

            const SizedBox(width: 10),

            if (loading) const SizedBox(
              width: 20,
              height: 20,
              child: CupertinoActivityIndicator(),
            ),

          ],
        )
    );
  }
}
