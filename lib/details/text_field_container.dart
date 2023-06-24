// flutter
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {Key? key,
      required this.color,
      required this.borderColor,
      required this.shadowColor,
      required this.child})
      : super(key: key);

  final Color color;
  final Color borderColor;
  final Color shadowColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // デバイスのサイズを取得する
    final size = MediaQuery.of(context).size;
    // デバイスの高さ
    final double height = size.height;
    // デバイスの横の長さ
    final double width = size.width;
    return Center(
      child: Container(
        // symmetricは左右
        // verticalは上下
        // つまり上下左右対象に余白が入るということ
        margin: EdgeInsets.symmetric(vertical: 8.0),
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: shadowColor, blurRadius: 8.0, offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.circular(16.0)),
        child: child,
      ),
    );
  }
}
