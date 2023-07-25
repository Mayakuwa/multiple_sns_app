// flutter
import 'package:flutter/material.dart';
// packages
// widgetをグローバルに管理してくれるパッケージだよ
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// constans
import 'package:first_app/constants/routes.dart' as routes;
import 'package:first_app/constants/strings.dart';
import 'package:first_app/constants/enums.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/domain/following_token/following_token.dart';
import 'package:first_app/domain/like_post_token/like_post_token.dart';
import 'package:first_app/domain/like_comment_token/like_comment_token.dart';
import 'package:first_app/domain/like_reply_token/like_reply_token.dart';

// ViewとModelを橋渡ししてくれるよ
final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  int counter = 1;
  late User? currentUser;
  // lateで後で定める
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;

  // tokens
  List<FollowingToken> followingTokens = [];
  List<String> followingUids = [];
  List<LikePostToken> likePostTokens = [];
  List<String> likePostIds = [];
  List<LikeCommentToken> likeCommentTokens = [];
  List<String> likeCommentIds = [];
  List<LikeReplyToken> likeReplyTokens = [];
  List<String> likeReplyIds = [];

  MainModel() {
    init();
  }

  // initの中でcurrentUserを更新する。
  Future<void> init() async {
    startLoading();
    // 現在ログインしているユーザを監視する
    currentUser = FirebaseAuth.instance.currentUser;
    // ドキュメントのuidを取得する
    currentUserDoc = await FirebaseFirestore.instance
        .collection(usersFieldkey)
        .doc(currentUser!.uid)
        .get();
    // tokenを分配する
    await distributeTokens();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    // current Userのuidの取得が可能になりました
    endLoading();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> distributeTokens() async {
    final tokensQshot =
        await currentUserDoc.reference.collection('tokens').get();
    final tokenDocs = tokensQshot.docs;
    for (final token in tokenDocs) {
      final Map<String, dynamic> tokenMap = token.data();
      final TokenType tokenType = mapToTokenType(tokenMap: tokenMap);
      switch (tokenType) {
        case TokenType.following:
          final FollowingToken followingToken =
              FollowingToken.fromJson(tokenMap);
          followingTokens.add(followingToken);
          followingUids.add(followingToken.passiveUid);
          break;
        case TokenType.likePost:
          final LikePostToken likePostToken = LikePostToken.fromJson(tokenMap);
          likePostTokens.add(likePostToken);
          // print(likePostToken);
          likePostIds.add(likePostToken.postId);
          break;
        case TokenType.likeComment:
          final LikeCommentToken likeCommentToken =
              LikeCommentToken.fromJson(tokenMap);
          likeCommentTokens.add(likeCommentToken);
          likeCommentIds.add(likeCommentToken.postCommentId);
          break;
        case TokenType.likeReply:
          final LikeReplyToken likeReplyToken =
              LikeReplyToken.fromJson(tokenMap);
          likeReplyTokens.add(likeReplyToken);
          likeReplyIds.add(likeReplyToken.postCommentReplyId);
          break;
        case TokenType.mistake:
          break;
      }
    }
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout(
      {required BuildContext context, required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    // nullになる
    setCurrentUser();
    routes.toLoginPage(context: context);
  }
}
