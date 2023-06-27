// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:first_app/constants/ints.dart';

final snsBottomNavigationBarProvider =
    ChangeNotifierProvider((ref) => SnsBottomNavigationBarModel());

class SnsBottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;

  SnsBottomNavigationBarModel() {
    init();
  }

  void init() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onTabTapped({required int index}) {
    // ページ遷移
    pageController.animateToPage(index,
        duration: Duration(microseconds: pageAnimationDuration),
        curve: Curves.easeIn);
  }

  // ページコントローラ上書き
  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
