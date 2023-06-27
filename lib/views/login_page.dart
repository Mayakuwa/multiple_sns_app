// flutter
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:first_app/models/login_model.dart';
import 'package:first_app/models/main_model.dart';
// components
import 'package:first_app/details/rounded_text_field.dart';
import 'package:first_app/details/rounded_password_field.dart';
import 'package:first_app/details/rounded_button.dart';
// constans
import 'package:first_app/constants/strings.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mainProviderを監視する&呼び出す。
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailEditiongController =
        TextEditingController(text: loginModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(loginTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RounedTextField(
            keybordType: TextInputType.emailAddress,
            onChanged: (text) => loginModel.email = text,
            controller: emailEditiongController,
            color: Colors.white,
            borderColor: Colors.black,
            shadowColor: Colors.red,
            hintText: mailAddressText,
          ),
          RounedPassWordField(
              onChanged: (text) => loginModel.password = text,
              passwordEditingController: passwordEditingController,
              obsucreText: loginModel.isObsucure,
              toggleObscureText: () => loginModel.toggelIsObsucure(),
              color: Colors.white,
              borderColor: Colors.black,
              shadowColor: Colors.red),
          RoundedButton(
            onPressed: () async => await loginModel.login(context: context),
            withRate: 0.85,
            color: Colors.purple,
            textColor: Colors.white,
            text: loginText,
          )
        ],
      ),
    );
  }
}
