// flutter
import 'package:first_app/constants/themes.dart';
// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// models
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/themes_model.dart';
import 'package:first_app/models/sns_bottom_navigation_bar_model.dart';
import 'package:first_app/models/create_post_model.dart';
// options
import 'firebase_options.dart';
// components
import 'package:first_app/details/sns_bottom_navigation_bar.dart';
import 'package:first_app/details/sns_drawer.dart';
// views
import 'package:first_app/views/main/home_screen.dart';
import 'package:first_app/views/main/search_screen.dart';
import 'package:first_app/views/main/profile_screen.dart';
import 'package:first_app/views/login_page.dart';
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
    // アプリが起動した時に最初の時にユーザがログインしているかの確認。（1回しか使えない）
    final User? onceUser = FirebaseAuth.instance.currentUser;
    final ThemeModel themeModel = ref.watch(themeProvider);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: themeModel.isDarkTheme
            ? darkThemeData(context: context)
            : lightThemeData(context: context),
        home: onceUser == null
            ? const LoginPage()
            : MyHomePage(
                title: appTitle,
                themeModel: themeModel,
              ));
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title, required this.themeModel});
  final String title;
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mainModelが起動し、initが呼び出される
    final MainModel mainModel = ref.watch(mainProvider);
    final SnsBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);
    final CreatePostModel createPostModel = ref.watch(createPostProvider);

    // mainProviderを監視する&呼び出す。
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.new_label),
          onPressed: () => createPostModel.showPostFlashBar(
              context: context, mainModel: mainModel)),
      drawer: SnsDrawer(mainModel: mainModel, themeModel: themeModel),
      body: mainModel.isLoading
          ? Center(
              child: Text(loadingText),
            )
          : PageView(
              controller: snsBottomNavigationBarModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationBarModel.onPageChanged(index: index),
              children: [
                HomeScreen(mainModel: mainModel),
                SearchScreen(mainModel: mainModel),
                ProfileScreen(mainModel: mainModel)
              ],
            ),
      bottomNavigationBar: SnsBottomNavigationBar(
          snsBottomNavigationBarModel: snsBottomNavigationBarModel),
    );
  }
}
