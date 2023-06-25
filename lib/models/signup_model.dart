// flutter
import 'package:first_app/constants/strings.dart';
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';

// ViewとModelを橋渡ししてくれるよ
final signupProvider = ChangeNotifierProvider((ref) => SignupModel());

class SignupModel extends ChangeNotifier {
  int counter = 1;
  User? currentUser = null;
  // auth
  String email = "";
  String password = "";
  bool isObsucure = true;
// setStateはstatefulwidgetでしか使えないよ。変更を知らせるにはnotifyListenersを使う
  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    counter++;
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
        uid: uid,
        userName: aliceName,
        email: email,
        createdAt: now,
        updatedAt: now);
    final Map<String, dynamic> userData = firestoreUser.toJson();

    await FirebaseFirestore.instance
        .collection(usersFieldkey)
        .doc(uid)
        .set(userData);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(userCreateMsg)));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    // firebaseAuth
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
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
