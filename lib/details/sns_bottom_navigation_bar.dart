// flutter
import 'package:first_app/constants/bottom_navigation_bar_elements.dart';
import 'package:first_app/models/sns_bottom_navigation_bar_model.dart';
import 'package:flutter/material.dart';

class SnsBottomNavigationBar extends StatelessWidget {
  const SnsBottomNavigationBar(
      {Key? key, required this.snsBottomNavigationBarModel});

  final SnsBottomNavigationBarModel snsBottomNavigationBarModel;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNavigationBarElements,
      currentIndex: snsBottomNavigationBarModel.currentIndex,
      onTap: (index) => snsBottomNavigationBarModel.onTabTapped(index: index),
    );
  }
}
