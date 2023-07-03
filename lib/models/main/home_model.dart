// flutter
import 'package:first_app/constants/others.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ViewとModelを橋渡ししてくれるよ
final homeProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeModel extends ChangeNotifier {
  bool isLoading = false;
  late User? currentUser;

  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];

  HomeModel() {
    init();
  }

  Future<void> init() async {
    startLoading();
    final User? currentUser = returnAuthUser();
    final qshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(30)
        .get();
    postDocs = qshot.docs;
    endLoading();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
