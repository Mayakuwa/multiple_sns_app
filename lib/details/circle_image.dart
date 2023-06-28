// flutter
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage({Key? key, required this.lenght, required this.image});

  final double lenght;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lenght,
      height: lenght,
      decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.fill),
          border: Border.all(),
          shape: BoxShape.circle),
    );
  }
}
