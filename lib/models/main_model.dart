// flutter
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// constans
import 'package:first_app/constants/routes.dart' as routes;
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  int counter = 1;
  User? currentUser = null;
  // lateで後で定める
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;

  MainModel() {
    init();
  }

  // initの中でcurrentUserを更新する。
  Future<void> init() async {
    startLoading();
    // 現在ログインしているユーザを監視する
    currentUser = FirebaseAuth.instance.currentUser;
    // ドキュメントのuidを取得する
    currentUserDoc = await FirebaseFirestore.instance
        .collection(usersFieldkey)
        .doc(currentUser!.uid)
        .get();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    // current Userのuidの取得が可能になりました
    endLoading();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout(
      {required BuildContext context, required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    // nullになる
    setCurrentUser();
    routes.toLoginPage(context: context);
  }
}
