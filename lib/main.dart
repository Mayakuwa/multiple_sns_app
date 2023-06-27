// flutter
import 'package:first_app/views/login_page.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// models
import 'package:first_app/models/main_model.dart';
// options
import 'firebase_options.dart';
// contains
import 'package:first_app/constants/routes.dart' as routes;
// components
import 'package:first_app/details/rounded_button.dart';
// constans
import 'package:first_app/constants/strings.dart';

void main() async {
  // firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runappをProviderScopeで囲むことによって、riverpodを使えるようになる
  runApp(const ProviderScope(child: MyApp()));
}

// Modelを呼び出すためにConsumerWidgetを呼び出す。
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  // WidgetRefでモデル側の橋を読み込む
  Widget build(BuildContext context) {
    // アプリが起動した時に最初の時にユーザがログインしているかの確認。（1回しか使えない）
    final User? onceUser = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: onceUser == null ? LoginPage() : MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mainModelが起動し、initが呼び出される
    final MainModel mainModel = ref.watch(mainProvider);
    // mainProviderを監視する&呼び出す。
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: mainModel.isLoading == true
            ? Center(
                child: Text(loadingText),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoundedButton(
                      onPressed: () => routes.toSignupPage(context: context),
                      withRate: 0.5,
                      color: Colors.purple,
                      textColor: Colors.white,
                      text: signupText,
                    ),
                    RoundedButton(
                      onPressed: () => routes.toLoginPage(context: context),
                      withRate: 0.5,
                      color: Colors.purple,
                      textColor: Colors.white,
                      text: loginText,
                    ),
                    Center(
                      child: Text('私の名前は' +
                          mainModel.currentUserDoc['userName'] +
                          'です'),
                    ),
                    RoundedButton(
                      onPressed: () async => await mainModel.logout(
                          context: context, mainModel: mainModel),
                      withRate: 0.5,
                      color: Colors.purple,
                      textColor: Colors.white,
                      text: logoutText,
                    ),
                  ],
                ),
              ));
  }
}
