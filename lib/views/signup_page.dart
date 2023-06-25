// flutter
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:first_app/models/signup_model.dart';
// components
import 'package:first_app/details/rounded_text_field.dart';
import 'package:first_app/details/rounded_password_field.dart';
import 'package:first_app/details/rounded_button.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mainProviderを監視する&呼び出す。
    final SignupModel signupModel = ref.watch(signupProvider);
    final TextEditingController emailEditiongController =
        TextEditingController(text: signupModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signupModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('サインアップ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RounedTextField(
            keybordType: TextInputType.emailAddress,
            onChanged: (text) => signupModel.email = text,
            controller: emailEditiongController,
            color: Colors.white,
            borderColor: Colors.black,
            shadowColor: Colors.purple,
            hintText: '新規登録用のメールアドレス',
          ),
          RounedPassWordField(
              onChanged: (text) => signupModel.password = text,
              passwordEditingController: passwordEditingController,
              obsucreText: signupModel.isObsucure,
              toggleObscureText: () => signupModel.toggelIsObsucure(),
              color: Colors.white,
              borderColor: Colors.black,
              shadowColor: Colors.purple),
          RoundedButton(
            onPressed: () async => await signupModel.createUser(context: context),
            withRate: 0.85,
            color: Colors.purple,
            textColor: Colors.white,
            text: '新規登録',
          )
        ],
      ),
    );
  }
}
