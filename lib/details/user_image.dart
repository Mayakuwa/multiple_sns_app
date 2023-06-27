// flutter
import 'package:flutter/material.dart';
// components
import 'package:first_app/details/circle_image.dart';

class UserImage extends StatelessWidget {
  UserImage({Key? key, required this.lenght, required this.userImageURL});

  final double lenght;
  final String userImageURL;

  @override
  Widget build(BuildContext context) {
    return userImageURL.isEmpty
        ? Container(
            width: lenght,
            height: lenght,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                shape: BoxShape.circle),
            child: Icon(Icons.person, size: lenght),
          )
        : CircleImage(lenght: lenght, image: NetworkImage(userImageURL));
  }
}
