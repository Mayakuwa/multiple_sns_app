// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// pages
import 'package:first_app/views/signup_page.dart';
import 'package:first_app/views/login_page.dart';
import 'package:first_app/views/account_page.dart';
import 'package:first_app/main.dart';
import 'package:first_app/views/main/passive_user_profile_page.dart';
import 'package:first_app/views/admin_page.dart';
import 'package:first_app/views/comments/comment_page.dart';
import 'package:first_app/views/replies/replies_page.dart';
// models
import 'package:first_app/models/main_model.dart';
import 'package:first_app/models/comment_model.dart';
// domain
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/domain/comment/comment.dart';
import 'package:first_app/domain/post/post.dart';

void toMyapp({required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

void toSignupPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => SignupPage()));

void toLoginPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => LoginPage()));

void toAccountPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AccountPage(mainModel: mainModel)));

void toPassiveUserProfilePage(
        {required BuildContext context,
        required FirestoreUser passiveUser,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PassiveUserProfilePage(
                passiveUser: passiveUser, mainModel: mainModel)));

void toAdminPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminPage(mainModel: mainModel)));

void toCommentPage(
        {required BuildContext context,
        required Post post,
        required DocumentSnapshot<Map<String, dynamic>> postDoc,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentPage(
                  post: post,
                  postDoc: postDoc,
                  mainModel: mainModel,
                )));

void toRepliesPage(
        {required BuildContext context,
        required Comment comment,
        required DocumentSnapshot<Map<String, dynamic>> commentDoc,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RepliesPage(
                comment: comment,
                commentDoc: commentDoc,
                mainModel: mainModel)));
