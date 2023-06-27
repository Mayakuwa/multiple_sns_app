import 'package:flutter/material.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
// constans
import 'package:first_app/constants/routes.dart' as routes;

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 1;
  User? currentUser = null;
  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> logout(
      {required BuildContext context, required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    // nullになる
    setCurrentUser();
    routes.toLoginPage(context: context, mainModel: mainModel);
  }
}
