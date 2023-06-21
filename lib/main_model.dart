import 'package:flutter/material.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 1;

// setStateはstatefulwidgetでしか使えないよ。変更を知らせるにはnotifyListenersを使う
  Future<void> createUser({required BuildContext context}) async {
    counter++;
    final uuid = Uuid();
    final String v4 = uuid.v4();
    final Timestamp now = Timestamp.now();
    print(now);

    final FirestoreUser firestoreUser =
        FirestoreUser(
          uid: v4,
          userName: 'Alice',
          createdAt: now,
          updatedAt: now
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();

    await FirebaseFirestore.instance.collection('users').doc(v4).set(userData);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザが作成されたよ')));
    notifyListeners();
  }
}
