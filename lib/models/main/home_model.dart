// flutter
import 'package:first_app/constants/others.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ViewとModelを橋渡ししてくれるよ
final homeProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeModel extends ChangeNotifier {
  bool isLoading = false;
  final RefreshController refreshController = RefreshController();
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  Query<Map<String, dynamic>> returnQuery() {
    final User? currentUser = returnAuthUser();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(30);
  }

  HomeModel() {
    init();
  }

  Future<void> init() async {
    await onReload();
  }

  Future<void> onRefresh() async {
    refreshController.refreshCompleted();
    if (postDocs.isNotEmpty) {
      // 新しいものが出てきた場合は新しいものを取得
      final qshot = await returnQuery().endBeforeDocument(postDocs.first).get();
      // qshotの並び順を反対にする
      final reversed = qshot.docs.reversed.toList();
      for (final postDoc in reversed) {
        // リストの先頭に詰める
        postDocs.insert(0, postDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload() async {
    final qshot = await returnQuery().get();
    postDocs = qshot.docs;
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    if (postDocs.isNotEmpty) {
      final qshot = await returnQuery().startAfterDocument(postDocs.last).get();
      for (final postDoc in qshot.docs) {
        // 追加して配列に詰める
        postDocs.add(postDoc);
      }
    }
    notifyListeners();
  }
}
