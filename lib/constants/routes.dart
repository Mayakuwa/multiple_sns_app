// flutter
import 'package:flutter/material.dart';
// pages
import 'package:first_app/views/signup_page.dart';
import 'package:first_app/views/login_page.dart';
import 'package:first_app/views/account_page.dart';
import 'package:first_app/main.dart';
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
