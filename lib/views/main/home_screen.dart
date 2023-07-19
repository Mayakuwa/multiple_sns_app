// flutter
import 'package:first_app/domain/post/post.dart';
import 'package:first_app/views/refresh_screen.dart';
import 'package:flutter/material.dart';
// models
import 'package:first_app/models/main/home_model.dart';
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/posts_models.dart';
import 'package:first_app/models/comment_model.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// components
import 'package:first_app/details/reload_screen.dart';
import 'package:first_app/details/post_card.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final postDocs = homeModel.postDocs;
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    return postDocs.isEmpty
        ? ReloadScreen(onReload: () async => homeModel.onReload())
        : RefreshScreen(
            onRefresh: () async => await homeModel.onRefresh(),
            onLoading: () async => await homeModel.onLoading(),
            refreshController: homeModel.refreshController,
            child: ListView.builder(
                itemCount: postDocs.length,
                itemBuilder: (BuildContext context, int index) {
                  final postDoc = postDocs[index];
                  final Post post = Post.fromJson(postDoc.data()!);
                  return PostCard(
                      post: post,
                      mainModel: mainModel,
                      postsModel: postsModel,
                      commentsModel: commentsModel,
                      postDoc: postDoc);
                }),
          );
  }
}
