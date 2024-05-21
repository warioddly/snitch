



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      leading: leadingTo != null || Navigator.canPop(context) && enableImplyLeading ? IconButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))),
          backgroundColor: WidgetStateProperty.all<Color>(
              theme.brightness == Brightness.dark ? const Color(0xFF232627) : const Color(0xFFE5E5E5)
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
        ),
        icon: Icon(
          CupertinoIcons.back,
          color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        onPressed: () {

          if (Navigator.canPop(context)) {
            Navigator.of(context).maybePop();
          } else if (leadingTo != null) {
            Navigator.of(context).pushNamed(leadingTo!);
          }

        },
      ) : null,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);


}