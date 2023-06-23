// flutter
import 'package:first_app/models/login_model.dart';
import 'package:flutter/material.dart';
// flutter package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// models
import 'package:first_app/models/login_model.dart';

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
        title: Text('ログイン'),
      ),
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => loginModel.email = text,
            controller: emailEditiongController,
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) => loginModel.password = text,
            controller: passwordEditingController,
            obscureText: loginModel.isObsucure,
            decoration: InputDecoration(
                suffix: InkWell(
              child: loginModel.isObsucure
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onTap: () => loginModel.toggelIsObsucure(),
            )),
          ),
          Center(
            child: loginModel.currentUser == null
                ? Text('nullです')
                : Text('nullじゃないよ'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await loginModel.login(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
