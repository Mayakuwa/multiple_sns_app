// flutter
import 'package:flutter/material.dart';
// models
import 'package:first_app/models/main/home_model.dart';
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/posts_models.dart';
// constans
import 'package:first_app/constants/strings.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// domain
import 'package:first_app/domain/post/post.dart';
// components
import 'package:first_app/details/user_image.dart';
import 'package:first_app/details/rounded_button.dart';
import 'package:first_app/details/post_like_button.dart';

// routes
import 'package:first_app/constants/routes.dart' as routes;

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key, required this.mainModel});
  final MainModel mainModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final postDocs = homeModel.postDocs;
    return homeModel.postDocs.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RoundedButton(
                    onPressed: () async => homeModel.onReload(),
                    withRate: 0.85,
                    color: Colors.purple,
                    textColor: Colors.white,
                    text: reloadText),
              )
            ],
          )
        : Column(
            children: [
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      onRefresh: () async => await homeModel.onRefresh(),
                      onLoading: () async => await homeModel.onLoading(),
                      controller: homeModel.refreshController,
                      child: ListView.builder(
                          itemCount: postDocs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final postDoc = postDocs[index];
                            final Post post = Post.fromJson(postDoc.data()!);
                            return Container(
                                margin: const EdgeInsets.all(16.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple),
                                    borderRadius: BorderRadius.circular(32.0)),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          UserImage(
                                            lenght: 32.0,
                                            userImageURL: post.uid ==
                                                    mainModel.firestoreUser.uid
                                                ? mainModel
                                                    .firestoreUser.userImageURL
                                                : post.imageURL,
                                          ),
                                          // PostLiskeButton(
                                          //     mainModel: mainModel,
                                          //     post: post,
                                          //     postsModel: postsModel,
                                          //     postDoc: postDoc)
                                        ]),
                                    Row(children: [
                                      Text(post.text,
                                          style: TextStyle(fontSize: 24))
                                    ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          PostLiskeButton(
                                              mainModel: mainModel,
                                              post: post,
                                              postsModel: postsModel,
                                              postDoc: postDoc),
                                          InkWell(
                                              child: Icon(Icons.comment),
                                              onTap: () => routes.toCommentPage(
                                                  context: context,
                                                  post: post,
                                                  postDoc: postDoc,
                                                  mainModel: mainModel))
                                        ]),
                                  ],
                                ));
                          })))
            ],
          );
  }
}
