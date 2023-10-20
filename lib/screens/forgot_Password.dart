import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Forget_Password extends StatelessWidget {
  const Forget_Password({super.key});

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
                    child: _Forget_PasswordPage(),
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

class _Forget_PasswordPage extends StatefulWidget {
  const _Forget_PasswordPage({super.key});

  @override
  State<_Forget_PasswordPage> createState() => _Forget_PasswordPageState();
}

class _Forget_PasswordPageState extends State<_Forget_PasswordPage> {

  String _emailAddress = '';
  String _password = '';
  String _confirmPassword = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
            "Find Your BuildNex Account",
            style: TextStyle(
              fontSize: 22,
                color: Color(0xFFF3D69B),
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Text(
            "Enter the email associated with your account to change your password",
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
            controller: _emailController,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your email here ...',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Email Address',
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
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 120),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: TextButton(
            onPressed: () {
              Get.toNamed('/ForgotPassCode');
              // Get.to(Forget_PasswordCode());
            },
            child: const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
