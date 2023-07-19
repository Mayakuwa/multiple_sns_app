// flutter
import 'package:flutter/material.dart';
// componets
import 'package:first_app/details/rounded_button.dart';
// model
import 'package:first_app/models/main/home_model.dart';
// constants
import 'package:first_app/constants/strings.dart';

class ReloadScreen extends StatelessWidget {
  ReloadScreen({Key? key, required this.onReload});
  final void Function()? onReload;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RoundedButton(
              onPressed: onReload,
              withRate: 0.85,
              color: Colors.purple,
              textColor: Colors.white,
              text: reloadText),
        )
      ],
    );
  }
}
