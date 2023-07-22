// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// string
import 'package:first_app/constants/strings.dart';
// model
import 'package:first_app/models/main_model.dart';
// domain
import 'package:first_app/domain/post/post.dart';
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/details/reload_screen.dart';
import 'package:first_app/details/rounded_button.dart';
import 'package:first_app/models/comment_model.dart';
// views
import 'package:first_app/views/comments/components/comment_card.dart';
import 'package:first_app/views/refresh_screen.dart';

class CommentPage extends ConsumerWidget {
  const CommentPage(
      {super.key,
      required this.post,
      required this.postDoc,
      required this.mainModel});

  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final commentDocs = commentsModel.commentDocs;
    return Scaffold(
      appBar: AppBar(title: Text(commentTitle)),
      body: commentDocs.isEmpty
          ? ReloadScreen(
              onReload: () async =>
                  await commentsModel.onReload(postDoc: postDoc))
          : RefreshScreen(
              onRefresh: () async =>
                  await commentsModel.onRefresh(postDoc: postDoc),
              onLoading: () async =>
                  await commentsModel.onLoading(postDoc: postDoc),
              refreshController: commentsModel.refreshController,
              child: ListView.builder(
                  itemCount: commentDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final commentDoc = commentDocs[index];
                    final Comment comment =
                        Comment.fromJson(commentDoc.data()!);
                    return CommentCard(
                        comment: comment,
                        mainModel: mainModel,
                        commentsModel: commentsModel,
                        post: post,
                        commentDoc: commentDoc);
                  }),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.new_label),
          onPressed: () => commentsModel.showCommentFlashBar(
              context: context, mainModel: mainModel, postDoc: postDoc)),
    );
  }
}
