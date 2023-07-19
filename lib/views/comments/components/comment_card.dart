// flutter
import 'package:first_app/models/main_model.dart';
import 'package:first_app/views/comments/components/comment_like_button.dart';
import 'package:flutter/material.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';
// details
import 'package:first_app/details/card_container.dart';
import 'package:first_app/details/user_image.dart';

class CommentCard extends StatelessWidget {
  CommentCard({Key? key, required this.comment, required this.mainModel});

  final Comment comment;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
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
              CommentLiskeButton(mainModel: mainModel, comment: comment)
            ]),
          ],
        ));
  }
}
