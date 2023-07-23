// flutter
import 'package:first_app/constants/strings.dart';
import 'package:first_app/details/reload_screen.dart';
import 'package:first_app/domain/reply/reply.dart';
import 'package:first_app/views/refresh_screen.dart';
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// model
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/replies_model.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';

class RepliesPage extends ConsumerWidget {
  const RepliesPage(
      {super.key,
      required this.comment,
      required this.commentDoc,
      required this.mainModel});
  final Comment comment;
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    final replyDocs = repliesModel.replyDocs;
    return Scaffold(
      appBar: AppBar(title: const Text(repliesTitle)),
      body: replyDocs.isEmpty
          ? ReloadScreen(
              onReload: () async =>
                  await repliesModel.onReload(commentDoc: commentDoc))
          : RefreshScreen(
              onRefresh: () async =>
                  await repliesModel.onRefresh(commentDoc: commentDoc),
              onLoading: () async =>
                  await repliesModel.onLoading(commentDoc: commentDoc),
              refreshController: repliesModel.refreshController,
              child: ListView.builder(
                  itemCount: replyDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final replyDoc = replyDocs[index];
                    final Reply reply = Reply.fromJson(replyDoc.data()!);
                    return ListTile(title: Text(reply.reply));
                  }),
            ),
    );
  }
}
