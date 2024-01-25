import 'package:buildnex/classes/language.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

void main() {
  runApp(const WelcomePage());
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  late VoidCallback moveToLoginPage;
  late VoidCallback moveToRegisterPage;

  @override
  void dispose() {
    // Cleanup code goes here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    moveToLoginPage = () {
      Get.toNamed("/Login");
    };

    moveToRegisterPage = () {
      Get.toNamed("/Register");
    };

     return Directionality(
       textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF122247), //#abcdd2 chose this color instead
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Image(
                      image: AssetImage('images/Logo_title.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: 200,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        key: Key('login_button'),
                        onPressed: () {
                          moveToLoginPage();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.welcomePageLogin,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        key: Key('register_button'),
                        onPressed: () {
                          moveToRegisterPage() ;
                        },
                        child: Text(
                          AppLocalizations.of(context)!.welcomePageRegister,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width > 930
                      ?
                  80
                      :
                  MediaQuery.of(context).size.width / 30,
                  left: MediaQuery.of(context).size.width > 930
                      ?
                  MediaQuery.of(context).size.width / 3 - 40
                      :
                  MediaQuery.of(context).size.width / 1.6,
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<Language>(
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 30,
                      ),
                      onChanged: (Language? value) async {
                        if(value != null){
                          Locale _locale = await setLocale(value.languageCode);
                          MyApp.setLocal(context, _locale);
                        }
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.only(right : 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    e.flag,
                                    style: const TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(e.name)
                                ],
                              ),
                            ),
                          )
                      ).toList(),
                    ),
                  )
                ),
              ]
            ),
          ),
        ),
    ),
     );
  }
}


