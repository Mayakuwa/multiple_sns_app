// flutter
import 'package:first_app/models/comment_model.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(commentTitle)),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.new_label),
          onPressed: () => commentsModel.showCommentFlashBar(
              context: context, mainModel: mainModel)),
    );
  }
}
