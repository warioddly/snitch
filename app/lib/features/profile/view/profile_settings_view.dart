import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/features/profile/view/profile_theme_settings_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/list/menu_list_tile.dart';

class ProfileSettingsView extends StatelessWidget {

  const ProfileSettingsView({super.key});

  static const String route = '/profile-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Profile Settings',
        enableImplyLeading: true,
      ),
      body: ContentBox(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [

            ...[
                MenuListTileItem(
                  title: 'Preferences',
                  subtitle: "Change bot's preferences",
                  icon: CupertinoIcons.gear_alt,
                  onTap: () => print('Preferences'),
                ),
                MenuListTileItem(
                  title: 'Theme',
                  subtitle: "Change the app's theme",
                  icon: CupertinoIcons.paintbrush,
                  onTap: () {
                    Navigator.pushNamed(context, ProfileThemeSettingsView.route);
                  }
                ),
                MenuListTileItem(
                  title: 'About',
                  subtitle: "View information about the app",
                  icon: CupertinoIcons.info,
                  onTap: () => print('Information'),
                ),
                MenuListTileItem(
                    title: 'Delete Bot',
                    icon: CupertinoIcons.delete,
                    onTap: () => print('Delete bot'),
                    type: MenuListTileType.ERROR,
                    enableTrailing: false
                ),
            ].map((item) => MenuListTile(item: item)),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${APP_NAME.toUpperCase()} v1.0.0",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )

          ],
        ),
      )
    );
  }
}