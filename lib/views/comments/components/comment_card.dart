// flutter
import 'package:first_app/details/card_container.dart';
import 'package:flutter/material.dart';
// domain
import 'package:first_app/domain/comment/comment.dart';

class CommentCard extends StatelessWidget {
  CommentCard({Key? key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
        child: ListTile(title: Text(comment.comment)),
        borderColor: Colors.purple);
  }
}
