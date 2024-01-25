import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:buildnex/Widgets/resetPassword.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/Admin/mainScreen.dart';
import 'package:buildnex/screens/MSG_System/listChatScreen.dart';
import 'package:buildnex/screens/Notification/homepageNotification.dart';
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
import 'package:buildnex/screens/taskReview_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildnex/screens/welcomePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:buildnex/screens/serviceProviderTasks.dart';
// import 'Tasks/tasks_SP/PropertSurvey/propertySurveyTask.dart';
// import 'Tasks/tasks_SP/SoilTesting/soilTestingSP.dart';
// import 'Tasks/tasks_SP/LocalGovernorate_PermitsSP/localGovernoratePermitsSP.dart';
// import 'Tasks/tasks_SP/Task4/task4_SP.dart';
// import 'Tasks/tasks_SP/Task5/task5SP.dart';
// import 'Tasks/tasks_SP/Task6/task6SP.dart';

import 'Tasks/tasks_HO/PropertySurvey/task1_HO.dart';
import 'Tasks/tasks_HO/LocalGovernorate_Permits/localGovernoratePermits.dart';
import 'Tasks/tasks_HO/SoilTesting/soilTesting.dart';
import 'Tasks/tasks_HO/Task10/task10_HO.dart';
import 'Tasks/tasks_HO/Task11/task11_HO.dart';
import 'Tasks/tasks_HO/Task12/task12_HO.dart';
import 'Tasks/tasks_HO/Task13/task13_HO.dart';
import 'Tasks/tasks_HO/Task14/task14_HO.dart';
import 'Tasks/tasks_HO/Task15/task15_HO.dart';
import 'Tasks/tasks_HO/Task4/task4_HO.dart';
import 'Tasks/tasks_HO/Task5/governmentalPermittive.dart';
import 'Tasks/tasks_HO/Task6/task6HO.dart';
import 'Tasks/tasks_HO/Task7/task7_HO.dart';
import 'Tasks/tasks_HO/Task8/task8_HO.dart';
import 'Tasks/tasks_HO/Task9/task9_HO.dart';


import 'Tasks/tasks_SP/LocalGovernorate_PermitsSP/localGovernoratePermitsSP.dart';
import 'Tasks/tasks_SP/PropertSurvey/propertySurveyTask.dart';
import 'Tasks/tasks_SP/SoilTesting/soilTestingSP.dart';
import 'Tasks/tasks_SP/Task10/task10_SP.dart';
import 'Tasks/tasks_SP/Task11/task11_SP.dart';
import 'Tasks/tasks_SP/Task12/task12_SP.dart';
import 'Tasks/tasks_SP/Task13/task13_SP.dart';
import 'Tasks/tasks_SP/Task14/task14_SP.dart';
import 'Tasks/tasks_SP/Task15/task15_SP.dart';
import 'Tasks/tasks_SP/Task4/task4_SP.dart';
import 'Tasks/tasks_SP/Task5/task5SP.dart';
import 'Tasks/tasks_SP/Task6/task6SP.dart';
import 'Tasks/tasks_SP/Task7/task7_SP.dart';
import 'Tasks/tasks_SP/Task8/task8_SP.dart';
import 'Tasks/tasks_SP/Task9/task9_SP.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocal(BuildContext context , Locale newLocale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale? _locale ;

  setLocale (Locale locale){
    setState(() {
      _locale = locale ;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Welcome Page',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en' , ''), // English
      //   Locale('ar' , ''), // Arabic
      // ],

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
        '/HomeOwner/AddReview':(context) =>  TaskReviewHO(),
        '/Notifications':(context) =>  HomePageNotification(),
        '/Messages':(context) =>  ListChatScreen(),
        '/HomePage/Admin':(context) =>  MainAdminPage(),

        '/ServiceProviderTasks/Task1':(context) => SpPropertySurvey(),
        '/ServiceProviderTasks/Task2':(context) => LocalGovernoratePermitsSP(),
        '/ServiceProviderTasks/Task3':(context) => SoilTestingSP(),
        '/ServiceProviderTasks/Task4':(context) => DesignAndPlanningSP(),
        '/ServiceProviderTasks/Task5':(context) => GovernemntalPermittiveSP(),
        '/ServiceProviderTasks/Task6':(context) => ConstructionSP(),
        '/ServiceProviderTasks/Task7':(context) => PlumbingInstallSP(),
        '/ServiceProviderTasks/Task8':(context) => ElectricalInstallSP(),
        '/ServiceProviderTasks/Task9':(context) => InsulationInstallSP(),
        '/ServiceProviderTasks/Task10':(context) => DoorFrameInstallSP(),
        '/ServiceProviderTasks/Task11':(context) => PlasteringSP(),
        '/ServiceProviderTasks/Task12':(context) => TileInstallSP() ,
        '/ServiceProviderTasks/Task13':(context) => WindowInstallationSP(),
        '/ServiceProviderTasks/Task14':(context) => DoorInstallationSP(),
        '/ServiceProviderTasks/Task15':(context) => PaintingSP(),


        '/HomeOwnerTasks/Task1':(context) => HOPropertySurvey(),
        '/HomeOwnerTasks/Task2':(context) => LocalGovernoratePermits(),
        '/HomeOwnerTasks/Task3':(context) => SoilTesting(),
        '/HomeOwnerTasks/Task4':(context) => DesignAndPlanningHO(),
        '/HomeOwnerTasks/Task5':(context) => GovernemntalPermittiveHO(),
        '/HomeOwnerTasks/Task6':(context) => ConstructionHO(),
        '/HomeOwnerTasks/Task7':(context) => PlumbingInstallHO(),
        '/HomeOwnerTasks/Task8':(context) => ElectricalInstallHO() ,
        '/HomeOwnerTasks/Task9':(context) => InsulationInstallHO(),
        '/HomeOwnerTasks/Task10':(context) => DoorFrameInstallHO(),
        '/HomeOwnerTasks/Task11':(context) => PlasteringHO(),
        '/HomeOwnerTasks/Task12':(context) => TileInstallHO(),
        '/HomeOwnerTasks/Task13':(context) => WindowInstallationHO(),
        '/HomeOwnerTasks/Task14':(context) => DoorInstallationHO(),
        '/HomeOwnerTasks/Task15':(context) => PaintingHO(),
      },

    );
  }
}