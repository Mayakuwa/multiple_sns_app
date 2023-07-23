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
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final commentQshot =
        await FirebaseFirestore.instance.collectionGroup('postComments').get();
    for (final commentDoc in commentQshot.docs) {
      batch.delete(commentDoc.reference);
    }
    // for (final post in postsQshot.docs) {
    //   batch.update(post.reference, {'commentCount': FieldValue.delete()});
    // }

    await batch.commit();
  }
}
