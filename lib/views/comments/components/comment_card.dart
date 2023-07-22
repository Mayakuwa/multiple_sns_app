// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/post/post.dart';
// details
import 'package:first_app/details/card_container.dart';
import 'package:first_app/details/user_image.dart';
// models
import 'package:first_app/models/comment_model.dart';
import 'package:first_app/models/main_model.dart';
// page
import 'package:first_app/views/comments/components/comment_like_button.dart';

class CommentCard extends StatelessWidget {
  CommentCard(
      {Key? key,
      required this.comment,
      required this.mainModel,
      required this.commentsModel,
      required this.post,
      required this.commentDoc});

  final Comment comment;
  final MainModel mainModel;
  final CommentsModel commentsModel;
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;

  @override
  Widget build(BuildContext context) {
    final isLike = mainModel.likeCommentIds.contains(comment.postCommentId);
    final plusOneCount = comment.likeCount + 1;
    return CardContainer(
        borderColor: Colors.purple,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              UserImage(
                lenght: 32.0,
                userImageURL: comment.userImageURL,
              ),
            ]),
            Row(children: [
              Text(comment.comment, style: TextStyle(fontSize: 24))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              InkWell(child: Icon(Icons.comment), onTap: () {}),
              Row(
                children: [
                  CommentLikeButton(
                      mainModel: mainModel,
                      comment: comment,
                      commentsModel: commentsModel,
                      post: post,
                      commentDoc: commentDoc),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(isLike
                        ? plusOneCount.toString()
                        : comment.likeCount.toString()),
                  )
                ],
              )
            ]),
          ],
        ));
  }
}
