// flutter
import 'package:first_app/domain/comment/comment.dart';
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// model
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/posts_models.dart';
// domain
import 'package:first_app/domain/post/post.dart';

class CommentLiskeButton extends StatelessWidget {
  CommentLiskeButton(
      {Key? key, required this.mainModel, required this.comment});
  final MainModel mainModel;
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return mainModel.likeCommentIds.contains(comment.postCommentId)
        ? InkWell(
            child: const Icon(Icons.favorite, color: Colors.red), onTap: () {})
        : InkWell(child: const Icon(Icons.favorite), onTap: () {});
  }
}
