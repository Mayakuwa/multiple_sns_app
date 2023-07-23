// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// constants
import 'package:first_app/constants/routes.dart' as routes;

// ViewとModelを橋渡ししてくれるよ
final repliesProvider = ChangeNotifierProvider((ref) => RepliesModel());

class RepliesModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  String replyString = '';
  List<DocumentSnapshot<Map<String, dynamic>>> replyDocs = [];
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) {
    // commentに紐づいたreplyが欲しい
    return commentDoc.reference
        .collection('postCommentReplies')
        .orderBy('likeCount', descending: true);
  }

  // 同じデータを無駄に取得しないようにする
  String indexPostCommentId = '';
  // リプライボタンが押された時の処理
  Future<void> init(
      {required BuildContext context,
      required Comment comment,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required MainModel mainModel}) async {
    refreshController = RefreshController();
    routes.toRepliesPage(
        context: context,
        comment: comment,
        commentDoc: commentDoc,
        mainModel: mainModel);
    final String postCommentId = comment.postCommentId;
    if (indexPostCommentId != postCommentId) {
      await onReload(commentDoc: commentDoc);
    }
    indexPostCommentId = comment.postCommentId;
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    refreshController.refreshCompleted();
    if (replyDocs.isNotEmpty) {
      // 新しいものが出てきた場合は新しいものを取得
      final qshot = await returnQuery(commentDoc: commentDoc)
          .endBeforeDocument(replyDocs.first)
          .get();
      // qshotの並び順を反対にする
      final reversed = qshot.docs.reversed.toList();
      for (final commentDoc in reversed) {
        // リストの先頭に詰める
        replyDocs.insert(0, commentDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    final qshot = await returnQuery(commentDoc: commentDoc).get();
    replyDocs = qshot.docs;
    notifyListeners();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    refreshController.loadComplete();
    if (replyDocs.isNotEmpty) {
      final qshot = await returnQuery(commentDoc: commentDoc)
          .startAfterDocument(replyDocs.last)
          .get();
      for (final commentDoc in qshot.docs) {
        // 追加して配列に詰める
        replyDocs.add(commentDoc);
      }
    }
    notifyListeners();
  }
}
