import 'package:flutter/material.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  int counter = 0;

// setStateはstatefulwidgetでしか使えないよ。変更を知らせるにはnotifyListenersを使う
  Future<void> createUser({required BuildContext context}) async {
    counter++;
    final uuid = Uuid();
    final String v4 = uuid.v4();
    final Map<String, dynamic> userDate = {'userName': 'Alice', 'uid': v4};
    await FirebaseFirestore.instance.collection('users').doc(v4).set(userDate);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ユーザが作成されたよ')));
    notifyListeners();
  }
}
