// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constant
import 'package:first_app/constants/voids.dart' as voids;
import 'package:first_app/constants/routes.dart' as routes;
// model
import 'package:first_app/models/main_model.dart';
// component
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/domain/post/post.dart';

// ViewとModelを橋渡ししてくれるよ
final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  RefreshController refreshController = RefreshController();
  bool isLoading = false;
  String commentString = "";
  List<DocumentSnapshot<Map<String, dynamic>>> commentDocs = [];
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    // postに紐づいたコメントが欲しい
    return postDoc.reference
        .collection('postComments')
        .orderBy('likeCount', descending: true);
  }

  // 同じデータを無駄に取得しないようにする
  String indexPostId = '';

  // コメントボタンが押された時の処理
  Future<void> init(
      {required BuildContext context,
      required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required MainModel mainModel}) async {
    refreshController = RefreshController();
    // コメントページへ遷移
    routes.toCommentPage(
        context: context, post: post, postDoc: postDoc, mainModel: mainModel);
    // 違う投稿が押された場合には、firebaseから再取得
    if (indexPostId != post.postId) {
      await onReload(postDoc: postDoc);
    }
    indexPostId = post.postId;
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.refreshCompleted();
    if (commentDocs.isNotEmpty) {
      // 新しいものが出てきた場合は新しいものを取得
      final qshot = await returnQuery(postDoc: postDoc)
          .endBeforeDocument(commentDocs.first)
          .get();
      // qshotの並び順を反対にする
      final reversed = qshot.docs.reversed.toList();
      for (final commentDoc in reversed) {
        // リストの先頭に詰める
        commentDocs.insert(0, commentDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    startLoading();
    final qshot = await returnQuery(postDoc: postDoc).get();
    commentDocs = qshot.docs;
    endLoading();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.loadComplete();
    if (commentDocs.isNotEmpty) {
      final qshot = await returnQuery(postDoc: postDoc)
          .startAfterDocument(commentDocs.last)
          .get();
      for (final commentDoc in qshot.docs) {
        // 追加して配列に詰める
        commentDocs.add(commentDoc);
      }
    }
    notifyListeners();
  }

  void showCommentFlashBar({
    required BuildContext context,
    required MainModel mainModel,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
  }) {
    voids.showFlashBar(
        context: context,
        textEditingController: textEditingController,
        onChanged: (value) => commentString = value,
        titleString: createCommentText,
        primaryActionColor: Colors.purple,
        primaryActionBuilder: (_, controller, __) {
          return InkWell(
            onTap: () async {
              if (textEditingController.text.isNotEmpty) {
                // メインの動作
                await createComment(
                    currentUserDoc: mainModel.currentUserDoc,
                    firestoreUser: mainModel.firestoreUser,
                    postDoc: postDoc);
                await controller.dismiss();
                commentString = "";
                textEditingController.text = "";
              } else {
                await controller.dismiss();
              }
            },
            child: Icon(Icons.send, color: Colors.purple),
          );
        });
  }

  Future<void> createComment({
    required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
    required FirestoreUser firestoreUser,
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
  }) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentId = returnUuidV4();
    final Comment comment = Comment(
        uid: activeUid,
        comment: commentString,
        likeCount: 0,
        postCommentId: postCommentId,
        postCommentReplyCount: 0,
        userName: firestoreUser.userName,
        userImaheURL: '',
        createdAt: now,
        updatedAt: now);
    await postDoc.reference
        .collection('postComments')
        .doc(postCommentId)
        .set(comment.toJson());
  }
}
