// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// model
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/posts_models.dart';
// domain
import 'package:first_app/domain/post/post.dart';

class PostLiskeButton extends StatelessWidget {
  PostLiskeButton(
      {Key? key,
      required this.mainModel,
      required this.post,
      required this.postsModel,
      required this.postDoc});
  final MainModel mainModel;
  final Post post;
  final PostsModel postsModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  @override
  Widget build(BuildContext context) {
    return mainModel.likePostIds.contains(post.postId)
        ? InkWell(
            child: const Icon(Icons.favorite, color: Colors.red),
            onTap: () async => await postsModel.unlike(
                post: post,
                postDoc: postDoc,
                postRef: postDoc.reference,
                mainModel: mainModel),
          )
        : InkWell(
            child: const Icon(Icons.favorite),
            onTap: () async => await postsModel.like(
                post: post,
                postDoc: postDoc,
                postRef: postDoc.reference,
                mainModel: mainModel));
  }
}
