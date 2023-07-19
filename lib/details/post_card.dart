// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/details/card_container.dart';
import 'package:first_app/models/comment_model.dart';
import 'package:flutter/material.dart';
// components
import 'package:first_app/details/user_image.dart';
import 'package:first_app/details/post_like_button.dart';
// domain
import 'package:first_app/domain/post/post.dart';
// model
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/posts_models.dart';

class PostCard extends StatelessWidget {
  PostCard(
      {Key? key,
      required this.post,
      required this.mainModel,
      required this.postsModel,
      required this.commentsModel,
      required this.postDoc});
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final MainModel mainModel;
  final PostsModel postsModel;
  final CommentsModel commentsModel;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
        borderColor: Colors.purple,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              UserImage(
                lenght: 32.0,
                userImageURL: post.userImageURL,
              ),
            ]),
            Row(children: [Text(post.text, style: TextStyle(fontSize: 24))]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              InkWell(
                  child: Icon(Icons.comment),
                  onTap: () async => await commentsModel.init(
                      context: context,
                      post: post,
                      postDoc: postDoc,
                      mainModel: mainModel)),
              PostLiskeButton(
                  mainModel: mainModel,
                  post: post,
                  postsModel: postsModel,
                  postDoc: postDoc)
            ]),
          ],
        ));
  }
}
