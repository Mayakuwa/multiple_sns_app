// flutter
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ViewとModelを橋渡ししてくれるよ
final loginProvider = ChangeNotifierProvider((ref) => LoginModel());

class LoginModel extends ChangeNotifier {
  // auth
  String email = "";
  String password = "";
  bool isObsucure = true;
  User? currentUser = null;

  Future<void> login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      currentUser = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggelIsObsucure() {
    //反対にする
    isObsucure = !isObsucure;
    notifyListeners();
  }
}
