// flutter
import 'package:first_app/models/main_model.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// domain
import 'package:first_app/domain/post/post.dart';
import 'package:first_app/domain/like_post_token/like_post_token.dart';
import 'package:first_app/domain/post_like/post_like.dart';
// constants
import 'package:first_app/constants/strings.dart';

// ViewとModelを橋渡ししてくれるよ
final postsProvider = ChangeNotifierProvider((ref) => PostsModel());

class PostsModel extends ChangeNotifier {
  Future<void> like(
      {required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required DocumentReference<Map<String, dynamic>> postRef,
      required MainModel mainModel}) async {
    // setting
    final String postId = post.postId;
    mainModel.likePostIds.add(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = post.uid;
    // 自分がいいねしたことの印
    final LikePostToken likePostToken = LikePostToken(
        activeUid: activeUid,
        passiveUid: passiveUid,
        createdAt: now,
        postRef: postRef,
        postId: postId,
        tokenId: tokenId,
        tokenType: 'likePost');
    // tokenを追加する
    mainModel.likePostTokens.add(likePostToken);
    await currentUserDoc.reference
        .collection('tokens')
        .doc(tokenId)
        .set(likePostToken.toJson());
    // 投稿がいいねされたことの印
    final PostLike postlike = PostLike(
        activeUid: activeUid,
        createdAt: now,
        passiveUid: passiveUid,
        postRef: postRef,
        postId: postId);
    // いいねする人が重複しないようにuidはドキュメントIDとする。
    await postDoc.reference
        .collection('postLikes')
        .doc(activeUid)
        .set(postlike.toJson());
    notifyListeners();
  }

  Future<void> unlike(
      {required Post post,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required DocumentReference<Map<String, dynamic>> postRef,
      required MainModel mainModel}) async {
    final String postId = post.postId;
    mainModel.likePostIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteLikePostToken = mainModel.likePostTokens
        .where((element) => element.postId == postId)
        .toList()
        .first;
    // tokenを削除する
    mainModel.likePostTokens.remove(deleteLikePostToken);
    // 自分がいいねしたことの印を削除
    // いいねしているTokenを取得する。qshotというdataの塊を取得
    await currentUserDoc.reference
        .collection('tokens')
        .doc(deleteLikePostToken.tokenId)
        .delete();
    // 受動的ないいね(いいねされた投稿)がされたdataを削除する
    await postDoc.reference.collection('postLikes').doc(activeUid).delete();
    notifyListeners();
  }
}
