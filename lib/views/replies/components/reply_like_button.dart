// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// model
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/comment_model.dart';
import 'package:first_app/models/replies_model.dart';
// domain
import 'package:first_app/domain/post/post.dart';
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/reply/reply.dart';

class ReplyLikeButton extends StatelessWidget {
  ReplyLikeButton(
      {Key? key,
      required this.mainModel,
      required this.reply,
      required this.replyDoc,
      required this.repliesModel,
      required this.comment});
  final MainModel mainModel;
  final Reply reply;
  final DocumentSnapshot<Map<String, dynamic>> replyDoc;
  final RepliesModel repliesModel;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final bool isLike =
        mainModel.likeReplyIds.contains(reply.postCommentReplyId);
    final likeCount = reply.likeCount;
    final int plusOneCount = likeCount + 1;
    return Row(children: [
      Container(
        child: isLike
            ? InkWell(
                child: const Icon(Icons.favorite, color: Colors.red),
                onTap: () async => await repliesModel.like(
                    reply: reply,
                    mainModel: mainModel,
                    comment: comment,
                    replyDoc: replyDoc))
            : InkWell(
                child: const Icon(Icons.favorite),
                onTap: () async => await repliesModel.unlike(
                    reply: reply,
                    mainModel: mainModel,
                    comment: comment,
                    replyDoc: replyDoc)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(isLike ? plusOneCount.toString() : likeCount.toString()),
      )
    ]);
  }
}
