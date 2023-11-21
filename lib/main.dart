import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:buildnex/Widgets/resetPassword.dart';
import 'package:buildnex/screens/forgot_Password.dart';
import 'package:buildnex/screens/homeNav_ServiceProvider.dart';
import 'package:buildnex/screens/homeNav_homeOwner.dart';
import 'package:buildnex/screens/homePage.dart';
import 'package:buildnex/screens/login.dart';
import 'package:buildnex/screens/projectDesc_HO.dart';
import 'package:buildnex/screens/projectNav_homeOwner.dart';
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
      '/ForgotPass':(context) => Forget_Password(),
      '/ForgotPassCode':(context) => Forget_PasswordCode(),
      '/ResetPass':(context) => Reset_Password(),
      '/HomePage/HomeOwner':(context) => NavBarHomeOwner(),
      '/HomePage/ServiceProvider':(context) => NavBarServiceProvider(),
      '/HomePage/HomeOwner/ProjectPage':(context) => ProjectNavBar(),
      '/ProjectDescribtion':(context) => ProjectDescription(),
    },

  );
}
}
