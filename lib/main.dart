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

// Modelを呼び出すためにConsumerWidgetを呼び出す。
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  // WidgetRefでモデル側の橋を読み込む
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainModel.currentUser == null
          ? LoginPage(mainModel: mainModel)
          : MyHomePage(title: 'Flutter Demo Home Page', mainModel: mainModel),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () => routes.toSignupPage(context: context),
            child: Text('サインアップ'),
          ),
          ElevatedButton(
            onPressed: () =>
                routes.toLoginPage(context: context, mainModel: mainModel),
            child: Text('ログイン'),
          ),
        ],
      ),
    );
  }
}
