import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:snitch/core/services/database/migrations.dart';
import 'package:snitch/core/utils/extensions/build_context_extenstion.dart';
import 'package:snitch/core/services/database/db.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/features/user/views/user_bot_edit_view.dart';
import 'package:snitch/features/user/views/user_theme_settings_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/list/menu_list_tile.dart';

class UserSettingsView extends StatelessWidget {

  const UserSettingsView({super.key});

  static const String route = '/profile-settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Profile Settings',
        enableImplyLeading: false,
      ),
      body: ContentBox(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [

              ...[
                  MenuListTileItem(
                    title: 'Preferences',
                    subtitle: "Change bot's preferences",
                    icon: CupertinoIcons.gear_alt,
                    onTap: () => context.go(UserBotUpdateSettingView.route),
                  ),
                  MenuListTileItem(
                    title: 'Languages',
                    subtitle: "App language settings",
                    icon: CupertinoIcons.globe,
                    onTap: () => debugPrint('Preferences'),
                  ),
                  MenuListTileItem(
                    title: 'Commands',
                    subtitle: "Add your customs commands",
                    icon: CupertinoIcons.command,
                    onTap: () => debugPrint('Preferences'),
                  ),
                  MenuListTileItem(
                    title: 'Theme',
                    subtitle: "Change the app's theme",
                    icon: CupertinoIcons.paintbrush,
                    onTap: () => context.go(UserThemeSettingsView.route),
                  ),
                  MenuListTileItem(
                    title: 'About',
                    subtitle: "View information about the app",
                    icon: CupertinoIcons.info,
                    onTap: () => debugPrint('Information'),
                  ),
                  MenuListTileItem(
                      title: 'Delete Bot',
                      icon: CupertinoIcons.delete,
                      onTap: () async{

                        await Migrations.down(getIt<DB>().db);

                      },
                      type: MenuListTileType.ERROR,
                      enableTrailing: false
                  ),
              ].map((item) => MenuListTile(item: item)),

            ],
          ),
        ),
      )
    );
  }
}