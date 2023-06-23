import 'package:flutter/material.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 1;
  User? currentUser = null;
  String email = "";
  String password = "";
// setStateはstatefulwidgetでしか使えないよ。変更を知らせるにはnotifyListenersを使う
  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    counter++;
    final uuid = Uuid();
    final String v4 = uuid.v4();
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
        uid: uid,
        userName: 'Alice',
        email: email,
        createdAt: now,
        updatedAt: now);
    final Map<String, dynamic> userData = firestoreUser.toJson();

    await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザが作成されたよ')));
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
}
