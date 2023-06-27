import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(homeText),
    );
  }
}
