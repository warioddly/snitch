import 'package:flutter/material.dart';



enum MenuListTileType {
  PRIMARY,
  ERROR,
  WARNING,
  SUCCESS,
}


class MenuListTileItem {

  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? onTap;
  final MenuListTileType type;
  final bool enableTrailing;

  const MenuListTileItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.enableTrailing = true,
    this.type = MenuListTileType.PRIMARY,
  });

}


extension MenuListTileTypeExtension on MenuListTileType {
  Color? get color {
    switch (this) {
      case MenuListTileType.ERROR:
        return const Color(0xFFD32F2F);
      case MenuListTileType.WARNING:
        return const Color(0xFFFFA000);
      case MenuListTileType.SUCCESS:
        return const Color(0xFF00C853);
      default:
        return null;
    }
  }
}


class MenuListTile extends StatelessWidget {

  const MenuListTile({ super.key, required this.item});

  final MenuListTileItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
          item.title,
          style: theme.listTileTheme.titleTextStyle?.copyWith(color: item.type.color)
      ),
      subtitle: item.subtitle != null ? Text(
          item.subtitle!,
          style: theme.listTileTheme.subtitleTextStyle?.copyWith(color: item.type.color)
      ) : null,
      onTap: item.onTap,
      leading: Icon(item.icon, size: 25, color: item.type.color),
      trailing: item.enableTrailing ? const Icon(Icons.arrow_forward_ios) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}