// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// constants
import 'package:first_app/constants/others.dart';
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/post/post.dart';

// ViewとModelを橋渡ししてくれるよ
final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin() async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final String activeUid = returnAuthUser()!.uid;
    for (int i = 0; i < 100; i++) {
      final Timestamp now = Timestamp.now();
      final String postId = returnUuidV4();
      final Post post = Post(
          postId: postId,
          likeCount: 0,
          text: i.toString(),
          uid: activeUid,
          imageURL: "",
          hashTags: [],
          createdAt: now,
          updatedAt: now);
      final DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
          .instance
          .collection('users')
          .doc(activeUid)
          .collection('posts')
          .doc(postId);
      batch.set(ref, post.toJson());
    }
    await batch.commit();
  }
}
