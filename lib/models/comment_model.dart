// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flash/flash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constant
import 'package:first_app/constants/voids.dart' as voids;
// model
import 'package:first_app/models/main_model.dart';
// component
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/firestore_user/firestore_user.dart';

// ViewとModelを橋渡ししてくれるよ
final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String commentString = "";

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
