// flutter
import 'package:first_app/models/comment_model.dart';
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// model
import 'package:first_app/models/main_model.dart';
// domain
import 'package:first_app/domain/post/post.dart';
import 'package:first_app/domain/comment/comment.dart';

class CommentLikeButton extends StatelessWidget {
  CommentLikeButton(
      {Key? key,
      required this.mainModel,
      required this.comment,
      required this.commentsModel,
      required this.post,
      required this.commentDoc});
  final MainModel mainModel;
  final Comment comment;
  final CommentsModel commentsModel;
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  @override
  Widget build(BuildContext context) {
    return mainModel.likeCommentIds.contains(comment.postCommentId)
        ? InkWell(
            child: const Icon(Icons.favorite, color: Colors.red),
            onTap: () async => await commentsModel.unlike(
                comment: comment,
                mainModel: mainModel,
                post: post,
                commentDoc: commentDoc))
        : InkWell(
            child: const Icon(Icons.favorite),
            onTap: () async => await commentsModel.like(
                comment: comment,
                mainModel: mainModel,
                post: post,
                commentDoc: commentDoc));
  }
}
