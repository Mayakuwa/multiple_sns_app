// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';

// ViewとModelを橋渡ししてくれるよ
final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin(
      {required DocumentSnapshot<Map<String, dynamic>> currenyUserDoc,
      required FirestoreUser firestoreUser}) async {
    // 管理者のみできる
    // ユーザのemailの削除
    // final WriteBatch batch = FirebaseFirestore.instance.batch();
    // final usersQshot =
    //     await FirebaseFirestore.instance.collection('users').get();
    // for (final user in usersQshot.docs) {
    //   batch.update(user.reference, {'email': FieldValue.delete()});
    // }
    // // postにuserName,userImageURLの追加
    // final postQshot = await currenyUserDoc.reference.collection('posts').get();
    // for (final post in postQshot.docs) {
    //   batch.update(post.reference, {
    //     'userName': firestoreUser.userName,
    //     'userImageURL': firestoreUser.userImageURL
    //   });
    // }
    // await batch.commit();
  }
}
