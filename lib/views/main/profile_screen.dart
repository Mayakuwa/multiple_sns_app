import 'package:flutter/material.dart';
import 'package:first_app/models/main_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key, required this.mainmodel});

  final MainModel mainmodel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          mainmodel.firestoreUser.userName,
          style: TextStyle(fontSize: 50),
        ),
      ],
    );
  }
}
