// flutter
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:first_app/models/signup_model.dart';
// components
import 'package:first_app/details/rounded_text_field.dart';

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
        children: [
          // TextFormField(
          //   keyboardType: TextInputType.emailAddress,
          //   onChanged: (text) => signupModel.email = text,
          //   controller: emailEditiongController,
          // ),
          RounedTextField(
            keybordType: TextInputType.emailAddress,
            onChanged: (text) => signupModel.email = text,
            controller: emailEditiongController,
            color: Colors.white,
            borderColor: Colors.black,
            shadowColor: Colors.purple,
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) => signupModel.password = text,
            controller: passwordEditingController,
            obscureText: signupModel.isObsucure,
            decoration: InputDecoration(
                suffix: InkWell(
              child: signupModel.isObsucure
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onTap: () => signupModel.toggelIsObsucure(),
            )),
          ),
          Center(
            child: signupModel.currentUser == null
                ? Text('nullです')
                : Text('nullじゃないよ'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await signupModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
