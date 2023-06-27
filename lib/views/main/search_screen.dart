import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(searchText),
    );
  }
}
