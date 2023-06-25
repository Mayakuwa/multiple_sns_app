// flutter
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.onPressed,
      required this.withRate,
      required this.color,
      required this.textColor,
      required this.text
    });

  final void Function()? onPressed;
  // 0 < withRate < 1.0
  final double withRate;
  final Color color;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Container(
        width: maxWidth * withRate,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text(text),
            ),
            style: ElevatedButton.styleFrom(
              primary: color,
              onPrimary: textColor,
            ),
          ),
        ));
  }
}
