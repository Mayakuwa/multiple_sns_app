// flutter
import 'package:first_app/views/login_page.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
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
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  // WidgetRefでモデル側の橋を読み込む
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainModel.currentUser == null
          ? LoginPage(mainModel: mainModel)
          : MyHomePage(title: appTitle, mainModel: mainModel),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title, required this.mainModel});

  final String title;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    // mainProviderを監視する&呼び出す。
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
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
                onPressed: () =>
                    routes.toLoginPage(context: context, mainModel: mainModel),
                withRate: 0.5,
                color: Colors.purple,
                textColor: Colors.white,
                text: loginText,
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
