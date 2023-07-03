// flutter
import 'package:first_app/domain/firestore_user/firestore_user.dart';
import 'package:first_app/views/admin_page.dart';
import 'package:flutter/material.dart';
// pages
import 'package:first_app/views/signup_page.dart';
import 'package:first_app/views/login_page.dart';
import 'package:first_app/views/account_page.dart';
import 'package:first_app/main.dart';
import 'package:first_app/views/main/passive_user_profile_page.dart';
// models
import 'package:first_app/models/main_model.dart';

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

void toAdminPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => AdminPage()));
