// flutter
import 'package:flutter/material.dart';
// pages
import 'package:first_app/views/signup_page.dart';
import 'package:first_app/views/login_page.dart';

void toSignupPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => SignupPage()));

void toLoginPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => LoginPage()));
