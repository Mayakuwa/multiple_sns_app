// flutter
import 'package:first_app/domain/follower/follower.dart';
import 'package:flutter/material.dart';
// constans
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/domain/following_token/following_token.dart';
// model
import 'package:first_app/models/main_model.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ViewとModelを橋渡ししてくれるよ
final passiveUserProfileProvider =
    ChangeNotifierProvider((ref) => PassiveUserProfileModel());

class PassiveUserProfileModel extends ChangeNotifier {
  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.add(passiveUser.uid);
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        passiveUid: passiveUser.uid, createdAt: now, tokenId: tokenId);
    // 現在のユーザ
    final FirestoreUser activeUser = mainModel.firestoreUser;
    final newActiveUser =
        activeUser.copyWith(followingCount: activeUser.followerCount + 1);
    // フロント側で先に描画させるためにここで処理させる
    mainModel.firestoreUser = newActiveUser;
    // 自分がフォローした印
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(activeUser.uid)
        .collection('tokens')
        .doc(tokenId)
        .set(followingToken.toJson());
    // 危険な例、フォローしているユーザーの数をプラス１している
    await FirebaseFirestore.instance
        .collection('users')
        .doc(activeUser.uid)
        .update({
      // Firebase上の値にプラス1。フロントエンドがDBに関わってこない更新になるので安全になる
      'followingCount': FieldValue.increment(1)
    });
    // 受動的なユーザ(フォローされたユーザ)がフォローされたdataを生成する
    final Follower follower = Follower(
        followedUid: passiveUser.uid,
        followerUid: activeUser.uid,
        createdAt: now);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(passiveUser.uid)
        .collection('followers')
        .doc(activeUser.uid)
        .set(follower.toJson());
    // フォローワーの数をプラス1している
    await FirebaseFirestore.instance
        .collection('users')
        .doc(passiveUser.uid)
        .update({
      // Firebase上の値にプラス1。フロントエンドがDBに関わってこない更新になるので安全になる
      'followerCount': FieldValue.increment(1)
    });
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);
    // 現在のユーザ
    final FirestoreUser activeUser = mainModel.firestoreUser;
    final newActiveUser =
        activeUser.copyWith(followingCount: activeUser.followerCount - 1);
    // フロント側で先に描画させるためにここで処理させる
    mainModel.firestoreUser = newActiveUser;
    notifyListeners();
    // followしているTokenを取得する。qshotというdataの塊を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(activeUser.uid)
        .collection('tokens')
        .where('passiveUid', isEqualTo: passiveUser.uid)
        .get();
    // 1個しか取得していないけど、Listで複数取得
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    // await FirebaseFirestore.instance.collection('users').doc(activeUser.uid).collection('tokens').doc(tokenId).delete();
    await token.reference.delete();
    // 危険な例、フォローしているユーザーの数をマイナス１している
    await FirebaseFirestore.instance
        .collection('users')
        .doc(activeUser.uid)
        .update({
      // Firebase上の値にマイナス1。フロントエンドがDBに関わってこない更新になるので安全になる
      'followingCount': FieldValue.increment(-1)
    });
    // 受動的なユーザ(フォローされたユーザ)がフォローされたdataを生成する
    await FirebaseFirestore.instance
        .collection('users')
        .doc(passiveUser.uid)
        .collection('followers')
        .doc(activeUser.uid)
        .delete();
    // フォローワーの数をマイナス1している
    await FirebaseFirestore.instance
        .collection('users')
        .doc(passiveUser.uid)
        .update({
      // Firebase上の値にマイナス1。フロントエンドがDBに関わってこない更新になるので安全になる
      'followerCount': FieldValue.increment(-1)
    });
  }
}
