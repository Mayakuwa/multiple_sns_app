// flutter
import 'package:flutter/material.dart';
// components
import 'package:first_app/constants/strings.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key});
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
          )
        ],
      ),
    );
  }
}
