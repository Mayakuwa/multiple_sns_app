// flutter
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// components
import 'package:first_app/constants/strings.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    Key? key,
    required this.mainModel
  });

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(accountTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(logoutText),
            onTap: () async => await mainModel.logout(
              context: context, mainModel: mainModel
            ),
          )
        ],
      ),
    );
  }
}
