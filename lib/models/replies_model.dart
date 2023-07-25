// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// model
import 'package:first_app/models/main_model.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/domain/reply/reply.dart';
// constants
import 'package:first_app/constants/routes.dart' as routes;
import 'package:first_app/constants/voids.dart' as voids;
import 'package:first_app/constants/strings.dart';

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

  void showReplyFlashBar({
    required BuildContext context,
    required MainModel mainModel,
    required Comment comment,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
  }) {
    voids.showFlashBar(
        context: context,
        textEditingController: textEditingController,
        onChanged: (value) => replyString = value,
        titleString: createReplyText,
        primaryActionColor: Colors.purple,
        primaryActionBuilder: (_, controller, __) {
          return InkWell(
            onTap: () async {
              if (textEditingController.text.isNotEmpty) {
                // メインの動作
                await createReply(
                    currentUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser,
                    comment: comment,
                    commentDoc: commentDoc);
                await controller.dismiss();
                replyString = "";
                textEditingController.text = "";
              } else {
                await controller.dismiss();
              }
            },
            child: const Icon(Icons.send, color: Colors.purple),
          );
        });
  }

  Future<void> createReply(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required Comment comment,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentReplyId = returnUuidV4();
    final Reply reply = Reply(
        uid: activeUid,
        reply: replyString,
        likeCount: 0,
        postRef: comment.postRef,
        postCommentRef: commentDoc.reference,
        postCommentReplyId: postCommentReplyId,
        userName: firestoreUser.userName,
        userImageURL: firestoreUser.userImageURL,
        createdAt: now);
    await commentDoc.reference
        .collection('postCommentReplies')
        .doc(postCommentReplyId)
        .set(reply.toJson());
  }
}
