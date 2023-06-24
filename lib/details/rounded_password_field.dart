// flutter
import 'package:first_app/details/text_field_container.dart';
import 'package:flutter/material.dart';

class RounedPassWordField extends StatelessWidget {
  const RounedPassWordField({
    Key? key,
    required this.onChanged,
    required this.passwordEditingController,
    required this.obsucreText,
    required this.toggleObscureText,
    required this.color,
    required this.borderColor,
    required this.shadowColor
  });
  final void Function(String)? onChanged;
  final TextEditingController passwordEditingController;
  final bool obsucreText;
  final void Function()? toggleObscureText;
  final Color color, borderColor, shadowColor;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      borderColor: borderColor,
      shadowColor: shadowColor,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        onChanged: onChanged,
        controller: passwordEditingController,
        obscureText: obsucreText,
        decoration: InputDecoration(
            suffix: InkWell(
          child:
              obsucreText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
          onTap: toggleObscureText,
        )),
      ),
    );
  }
}
