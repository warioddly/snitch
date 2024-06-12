import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/core/utils/extensions/build_context_extenstion.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {

  const Appbar({
    super.key,
    this.title,
    this.actions = const [],
    this.leadingTo,
    this.enableImplyLeading = false
  });

  final String? title;
  final String? leadingTo;
  final bool enableImplyLeading;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: title != null ? Text(
          title!,
          style: theme.textTheme.titleLarge
      ) : null,
      actions: actions,
      leading: leadingTo != null || context.canGoBack() && enableImplyLeading ? IconButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))),
          backgroundColor: WidgetStateProperty.all<Color>(
              theme.brightness == Brightness.dark ? const Color(0xFF232627) : const Color(0xFFE5E5E5)
          ),
        ),
        icon: Icon(
          CupertinoIcons.back,
          color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        onPressed: () {

          if (context.canGoBack()) {
            context.goBack();
          }
          else if (leadingTo != null) {
            context.go(leadingTo!);
          }

        },
      ) : null,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);


}