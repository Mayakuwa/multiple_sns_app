// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
// models
import 'package:first_app/main_model.dart';
// options
import 'firebase_options.dart';

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
    final TextEditingController emailEditiongController =
        TextEditingController(text: mainModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: mainModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => mainModel.email = text,
            controller: emailEditiongController,
          ),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: (text) => mainModel.password = text,
            controller: passwordEditingController,
          ),
          Center(
            child: mainModel.currentUser == null
                ? Text('nullです')
                : Text('nullじゃないよ'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await mainModel.createUser(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
