// flutter
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flash/flash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// components
import 'package:first_app/constants/strings.dart';
// domain
import 'package:first_app/domain/post/post.dart';
// model
import 'package:first_app/models/main_model.dart';

// ViewとModelを橋渡ししてくれるよ
final createPostProvider = ChangeNotifierProvider((ref) => CreatePostModel());

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String text = "";
  void showPostFlashBar(
      {required BuildContext context, required MainModel mainModel}) {
    context.showFlashBar(
      persistent: true,
      content: Form(
          child: TextFormField(
        controller: textEditingController,
        style: TextStyle(fontWeight: FontWeight.bold),
        onChanged: (value) => text = value,
        maxLines: 10,
      )),
      title: const Text(createPostTitle),
      // メインの動作
      primaryActionBuilder: (context, controller, _) {
        return InkWell(
          child: Icon(Icons.send),
          onTap: () async {
            if (textEditingController.text.isNotEmpty) {
              // メインの動作
              await createPost(mainModel: mainModel);
              await controller.dismiss();
              text = "";
            } else {
              await controller.dismiss();
            }
          },
        );
      },
      // 閉じる時の動作
      negativeActionBuilder: (context, controller, _) {
        return InkWell(
          child: Icon(Icons.close),
          onTap: () async => await controller.dismiss(),
        );
      },
    );
  }

  Future<void> createPost({required MainModel mainModel}) async {
    final Timestamp now = Timestamp.now();
    final DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
        mainModel.currentUserDoc;
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Post post = Post(
        postId: postId,
        likeCount: 0,
        text: text,
        postCommentCount: 0,
        uid: activeUid,
        imageURL: '',
        hashTags: [],
        userImageURL: firestoreUser.userImageURL,
        userName: firestoreUser.userName,
        createdAt: now,
        updatedAt: now);
    // currentUserDoc.referenceでFirebaseFirestore.instance.collection('users').doc(firestoreUser.uid)と同じ意味
    await currentUserDoc.reference
        .collection('posts')
        .doc(postId)
        .set(post.toJson());
  }
}
