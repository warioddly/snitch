import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/core/themes/theme.dart';
import 'package:snitch/shared/bloc/ui/theme_cubit.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/list/menu_list_tile.dart';

class UserThemeSettingsView extends StatelessWidget {

  const UserThemeSettingsView({super.key});

  static const String route = '/user-theme-settings';

  @override
  Widget build(BuildContext context) {

    final theme = getIt<ThemeCubit>();

    return Scaffold(
      appBar: const Appbar(
        title: 'Profile Theme Settings',
        enableImplyLeading: true,
      ),
      body: ContentBox(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [

            ...[
                MenuListTileItem(
                  title: 'Dark Theme',
                  icon: CupertinoIcons.moon,
                  onTap: () => theme.setTheme(SnitchThemeType.DARK),
                  enableTrailing: false,
                ),
                MenuListTileItem(
                  title: 'Light Theme',
                  icon: CupertinoIcons.sun_max,
                  onTap: () => theme.setTheme(SnitchThemeType.LIGHT),
                  enableTrailing: false,
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