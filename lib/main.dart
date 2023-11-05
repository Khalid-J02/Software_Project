import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:buildnex/Widgets/resetPassword.dart';
import 'package:buildnex/screens/forgot_Password.dart';
import 'package:buildnex/screens/homePage.dart';
import 'package:buildnex/screens/login.dart';
import 'package:buildnex/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildnex/screens/welcomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

@override
Widget build(BuildContext context) {
  return GetMaterialApp(
    title: 'Welcome Page',
    debugShowCheckedModeBanner: false,

    initialRoute: "/",

    routes: {
      '/':(context) => WelcomePage(),
      '/Login':(context) => Login(),
      '/Register':(context) => Register(),
      '/HomePage':(context) => HomePage(),
      '/ForgotPass':(context) => Forget_Password(),
      '/ForgotPassCode':(context) => Forget_PasswordCode(),
      '/ResetPass':(context) => Reset_Password(),

    },

  );
}
}
