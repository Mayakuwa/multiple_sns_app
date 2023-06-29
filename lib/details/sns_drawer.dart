// flutter
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/themes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// constants
import 'package:first_app/constants/strings.dart';
// routes
import 'package:first_app/constants/routes.dart' as routes;

class SnsDrawer extends StatelessWidget {
  SnsDrawer({Key? key, required this.mainModel, required this.themeModel});
  final MainModel mainModel;
  final ThemeModel themeModel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text(accountTitle),
              onTap: () =>
                  routes.toAccountPage(context: context, mainModel: mainModel)),
          ListTile(
              title: Text(themeTitle),
              trailing: CupertinoSwitch(
                value: themeModel.isDarkTheme,
                onChanged: ((value) => themeModel.setIsDarkTheme(value: value)),
              ))
        ],
      ),
    );
  }
}
