// flutter
import 'package:first_app/details/text_field_container.dart';
import 'package:flutter/material.dart';

class RounedTextField extends StatelessWidget {
  const RounedTextField(
      {Key? key,
      required this.keybordType,
      required this.onChanged,
      required this.controller,
      required this.color,
      required this.borderColor,
      required this.shadowColor,
      required this.hintText});
  final TextInputType keybordType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Color color;
  final Color borderColor;
  final Color shadowColor;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: TextFormField(
        keyboardType: keybordType,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        controller: controller,
      ),
    );
  }
}
