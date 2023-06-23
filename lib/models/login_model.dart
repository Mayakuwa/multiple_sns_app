// flutter
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
//constans
import 'package:first_app/constans/routes.dart' as routes;

// ViewとModelを橋渡ししてくれるよ
final loginProvider = ChangeNotifierProvider((ref) => LoginModel());

class LoginModel extends ChangeNotifier {
  // auth
  String email = "";
  String password = "";
  bool isObsucure = true;

  Future<void> login(
      {required BuildContext context, required MainModel mainModel}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // マイページに遷移
      routes.toMyapp(context: context);
      mainModel.setCurrentUser();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggelIsObsucure() {
    //反対にする
    isObsucure = !isObsucure;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
