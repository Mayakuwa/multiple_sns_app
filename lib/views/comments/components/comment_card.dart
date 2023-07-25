// flutter
import 'package:first_app/models/replies_model.dart';
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
// pakcage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    return CardContainer(
        borderColor: Colors.purple,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              UserImage(
                lenght: 32.0,
                userImageURL: comment.userImageURL,
              ),
              Text(comment.userName,
                  style:
                      TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis)),
              Expanded(child: SizedBox())
            ]),
            Row(children: [
              Text(comment.comment, style: TextStyle(fontSize: 24))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              InkWell(
                child: Icon(Icons.reply),
                onTap: () async => await repliesModel.init(
                    context: context,
                    comment: comment,
                    commentDoc: commentDoc,
                    mainModel: mainModel),
              ),
              CommentLikeButton(
                  mainModel: mainModel,
                  comment: comment,
                  commentsModel: commentsModel,
                  post: post,
                  commentDoc: commentDoc),
            ]),
          ],
        ));
  }
}
