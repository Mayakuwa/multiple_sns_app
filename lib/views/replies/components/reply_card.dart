// flutter
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/reply/reply.dart';
import 'package:first_app/views/replies/components/reply_like_button.dart';
import 'package:flutter/material.dart';
// domain
import 'package:first_app/domain/reply/reply.dart';
import 'package:first_app/domain/post/post.dart';
// details
import 'package:first_app/details/card_container.dart';
import 'package:first_app/details/user_image.dart';
// models
import 'package:first_app/models/replies_model.dart';
import 'package:first_app/models/main_model.dart';
// pakcage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReplyCard extends ConsumerWidget {
  ReplyCard(
      {Key? key,
      required this.reply,
      required this.mainModel,
      required this.comment,
      required this.replyDoc});
  final Reply reply;
  final DocumentSnapshot<Map<String, dynamic>> replyDoc;
  final MainModel mainModel;
  final Comment comment;

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
                userImageURL: reply.userImageURL,
              ),
              Text(reply.userName,
                  style:
                      TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis)),
              Expanded(child: SizedBox())
            ]),
            Row(children: [
              Text(reply.reply,
                  style:
                      TextStyle(fontSize: 24, overflow: TextOverflow.ellipsis)),
              Expanded(child: SizedBox()),
              ReplyLikeButton(
                  mainModel: mainModel,
                  reply: reply,
                  replyDoc: replyDoc,
                  repliesModel: repliesModel,
                  comment: comment)
            ]),
          ],
        ));
  }
}
