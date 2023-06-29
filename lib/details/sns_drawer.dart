// flutter
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// constants
import 'package:first_app/constants/strings.dart';
// routes
import 'package:first_app/constants/routes.dart' as routes;

class SnsDrawer extends StatelessWidget {
  SnsDrawer({
    Key? key,
    required this.mainModel
  });
  final MainModel mainModel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              title: Text(accountTitle),
              onTap: () => routes.toAccountPage(context: context, mainModel: mainModel))
        ],
      ),
    );
  }
}
