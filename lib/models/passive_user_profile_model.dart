// flutter
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
    // フォローした情報
    final FollowingToken followingToken = FollowingToken(
        passiveUid: passiveUser.uid,
        createdAt: Timestamp.now(),
        tokenId: tokenId);
    // 現在のユーザ
    final FirestoreUser activeUser = mainModel.firestoreUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(activeUser.uid)
        .collection('tokens')
        .doc(tokenId)
        .set(followingToken.toJson());
    notifyListeners();
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveFirestoreUser}) async {
    mainModel.followingUids.remove(passiveFirestoreUser.uid);
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // followしているTokenを取得する。qshotというdataの塊を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(activeUser.uid)
        .collection('tokens')
        .where('passiveUid', isEqualTo: passiveFirestoreUser.uid)
        .get();
    // 1個しか取得していないけど、Listで複数取得
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    // await FirebaseFirestore.instance.collection('users').doc(activeUser.uid).collection('tokens').doc(tokenId).delete();
    await token.reference.delete();
    notifyListeners();
  }
}
