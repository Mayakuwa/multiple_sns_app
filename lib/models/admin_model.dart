// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// ViewとModelを橋渡ししてくれるよ
final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin(
      {required DocumentSnapshot<Map<String, dynamic>> currenyUserDoc,
      required FirestoreUser firestoreUser}) async {
    // 管理者のみできる
    // final WriteBatch batch = FirebaseFirestore.instance.batch();
    // final postsQshot = await currenyUserDoc.reference.collection('posts').get();
    // for (final post in postsQshot.docs) {
    //   batch.update(post.reference, {'postCommentCount': 0});
    // }
    // for (final post in postsQshot.docs) {
    //   batch.update(post.reference, {'commentCount': FieldValue.delete()});
    // }

    // await batch.commit();
  }
}
