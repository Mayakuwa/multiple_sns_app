import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  CardContainer({Key? key, required this.child, required this.borderColor});

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(32.0)),
      child: child,
    );
  }
}
