import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:buildnex/Widgets/resetPassword.dart';
import 'package:buildnex/screens/continueRegister_HO.dart';
import 'package:buildnex/screens/continueRegister_SP.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:buildnex/screens/serviceProviderTasks.dart';
import 'Tasks/tasks_SP/PropertSurvey/propertySurveyTask.dart';
import 'Tasks/tasks_SP/SoilTesting/soilTestingSP.dart';
import 'Tasks/tasks_SP/LocalGovernorate_PermitsSP/localGovernoratePermitsSP.dart';
import 'Tasks/tasks_SP/Task4/task4_SP.dart';
import 'Tasks/tasks_SP/Task5/task5SP.dart';
import 'Tasks/tasks_SP/Task6/task6SP.dart';


void main() {
  dotenv.load();
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
      '/Register/HomeOwner':(context) => HomeOwnerRegister(),
      '/Register/ServiceProvider':(context) => ServiceProviderRegister(),
      '/ForgotPass':(context) => Forget_Password(),
      '/ForgotPassCode':(context) => Forget_PasswordCode(),
      '/ResetPass':(context) => Reset_Password(),
      '/HomePage/HomeOwner':(context) => NavBarHomeOwner(),
      '/HomePage/HomeOwner/ProjectPage':(context) => ProjectNavBar(),

      '/HomePage/ServiceProvider':(context) => NavBarServiceProvider(),

      '/ServiceProviderTasks/Task1':(context) => SpPropertySurvey(),
      '/ServiceProviderTasks/Task2':(context) => SoilTestingSP(),
      '/ServiceProviderTasks/Task3':(context) => LocalGovernoratePermitsSP(),
      '/ServiceProviderTasks/Task4':(context) => DesignAndPlanningSP(),
      '/ServiceProviderTasks/Task5':(context) => GovernemntalPermittiveSP(),
      '/ServiceProviderTasks/Task6':(context) => ConstructionSP(),


     // '/ServiceProviderTasks/Task7':(context) => ,
     // '/ServiceProviderTasks/Task8':(context) => ,
     //  '/ServiceProviderTasks/Task9':(context) => ,
     // '/ServiceProviderTasks/Task10':(context) => ,
     // '/ServiceProviderTasks/Task11':(context) => ,
     // '/ServiceProviderTasks/Task12':(context) => ,
     // '/ServiceProviderTasks/Task13':(context) => ,
     // '/ServiceProviderTasks/Task14':(context) => ,
     // '/ServiceProviderTasks/Task15':(context) => ,


      //'/ProjectDescribtion':(context) => ProjectDescription(),
    },

  );
}
}
