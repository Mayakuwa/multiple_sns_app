// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
// models
import 'package:first_app/models/main_model.dart';
// options
import 'firebase_options.dart';
// contains
import 'package:first_app/constans/routes.dart' as routes;

void main() async {
  // firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runappをProviderScopeで囲むことによって、riverpodを使えるようになる
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Modelを呼び出すためにConsumerWidgetを呼び出す。
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  // WidgetRefでモデル側の橋を読み込む
  Widget build(BuildContext context, WidgetRef ref) {
    // mainProviderを監視する&呼び出す。
    final MainModel mainModel = ref.watch(mainProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => routes.toSignupPage(context: context),
            child: Text('サインアップ'),
          ),
          ElevatedButton(
            onPressed: () => routes.toLoginPage(context: context),
            child: Text('ログイン'),
          ),
          Center(
            child: mainModel.currentUser == null
                ? Text('nullです')
                : Text('nullじゃないよ'),
          )
        ],
      ),
    );
  }
}
