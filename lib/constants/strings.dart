// packages
import 'package:uuid/uuid.dart';

// 日本語だと'サインアップ'、英語だと'signup'後々国際対応
// titles
const String appTitle = 'SNS';
const String singupTitle = '新規登録';
const String loginTitle = 'ログイン';
const String cropperTitle = 'Cropper';
const String accountTitle = 'アカウント';
const String themeTitle = 'テーマ';
// BottomNavigationBar
const String homeText = 'Home';
const String searchText = 'Search';
const String profileText = 'Profile';
// text
const String mailAddressText = 'メールアドレス';
const String passwordText = 'パスワード';
const String signupText = '新規登録を行う';
const String loginText = 'ログインする';
const String logoutText = 'ログアウトする';
const String loadingText = 'Loading';
// name
const String aliceName = 'Alice';
// fieldkey
const String usersFieldkey = 'users';
// messages
const String userCreateMsg = 'ユーザーが作成できました';
// pref key
const String isDarkThemePrefsKey = 'isDarkTheme';
// uui
String returnUuidV4() {
  const Uuid uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => "${returnUuidV4()}.jpg";
