import 'package:flutter/material.dart';

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

     return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFaad0d6), //#abcdd2 chose this color instead
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(
                image: AssetImage('images/Proj_Logo_title.png'),
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
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFF42747B),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextButton(
                  key: Key('register_button'),
                  onPressed: () {
                    moveToRegisterPage() ;
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


