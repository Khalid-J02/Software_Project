import 'package:buildnex/screens/forgot_Password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//

class Forget_PasswordCode extends StatelessWidget {
  const Forget_PasswordCode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/Log_Reg_back.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: const Image(
                    image: AssetImage('images/Logo_title.png'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xFF122247),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _Forget_PasswordCodePage(),
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

class _Forget_PasswordCodePage extends StatefulWidget {
  const _Forget_PasswordCodePage({super.key});

  @override
  State<_Forget_PasswordCodePage> createState() => _Forget_PasswordCodePageState();
}

class _Forget_PasswordCodePageState extends State<_Forget_PasswordCodePage> {


  final _passwordcodeController = TextEditingController();
  bool _obsecPass = true;
  bool _obsecConfPass = true;

  void _togglePassIcon() {
    setState(() {
      _obsecPass = !_obsecPass;
    });
  }

  void _toggleConfirmPassIcon() {
    setState(() {
      _obsecConfPass = !_obsecConfPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "We sent you a code",
            style: TextStyle(
                fontSize: 25,
                color: Color(0xFFF3D69B),
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Text(
            "check your email to get your verification code. If you need to request a new code, go back and re-enter your email.",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFFF3D69B),
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: TextFormField(
            controller: _passwordcodeController,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your code',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Verification Code',
              labelStyle: const TextStyle(
                color: Color(0xFFF3D69B),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFF3D69B),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFF3D69B),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/2.5), // 355
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 35,
              width: 90,
              margin: const EdgeInsets.only(left: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF3D69B),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/ForgotPass');
                  // Get.to(Forget_Password());
                },
                child: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2F4771),//
                  ),
                ),
              ),
            ),
            Container(
              height: 35,
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF2F4771),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/ResetPass');
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFF3D69B),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
