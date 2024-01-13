import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../APIRequests/userRegAPI.dart';
import '../Widgets/customAlertDialog.dart';


// void main() {
//   runApp(const Login());
// }


class Login extends StatelessWidget {
  const Login({super.key});

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
                    image: AssetImage('images/Proj_Logo_title.png'),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xFF122247),
                  child: const _LoginPage(),
                ),
              ),
              // Expanded(child: Text(MediaQuery.of(context).size.width.toString()))  // 930 width
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginPage extends StatefulWidget {
  const _LoginPage({super.key});

  @override
  State<_LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<_LoginPage> {

  late String _email = '' ;
  late String _password = '' ;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obsecPass = true ;

  void _togglePassIcon(){
    setState(() {
      _obsecPass = !_obsecPass ;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: MediaQuery.of(context).size.width > 930
            ?
              EdgeInsets.only(top: 30, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
            :
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
        Padding(
          padding: MediaQuery.of(context).size.width > 930
          ?
            EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
          :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: _passwordController,
            obscureText: _obsecPass,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your password here ...',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Password',
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
              suffixIcon: GestureDetector(
                onTap: () {
                  _togglePassIcon();
                },
                child: Icon(
                  _obsecPass
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: Color(0xFFF3D69B),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          margin: MediaQuery.of(context).size.width > 930
          ?
            EdgeInsets.only(top: 20, bottom: 10 , right: MediaQuery.of(context).size.width/2.5 , left: MediaQuery.of(context).size.width/2.5)
          :
          const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: TextButton(
            onPressed: () {
              _signIn() ;
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 930
                ? 19
                : 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account yet?,' ,
              style: TextStyle(
                color: Color(0xFFF3D69B),
                fontSize: MediaQuery.of(context).size.width > 930
                    ? 17
                    : 15,

              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/Register');
              },

              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 930
                  ? 17
                  : 15,
                  color: Color(0xFFF3D69B),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Forget Your Password?,' ,
              style: TextStyle(
                  color: Color(0xFFF3D69B),
                fontSize: MediaQuery.of(context).size.width > 930
                  ? 17
                  : 15
              ),
            ),
            TextButton(
              onPressed: () {

                Get.toNamed('/ForgotPass');
              },
              child: Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 930
                  ? 17
                  : 15,
                  color: Color(0xFFF3D69B),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _signIn() async {

    // Get the values from the text controllers
    _email = _emailController.text;
    _password = _passwordController.text;

    // Check if email or password is not filled
    if (_email.isEmpty || _password.isEmpty) {
      CustomAlertDialog.showErrorDialog(context, 'Please fill in all the required fields.');
      return;
    }
    final loginAPI = userRegAPI();
    final userData = await loginAPI.logIn(_email, _password) as Map;

    if (userData.containsKey('error'))
    {
      CustomAlertDialog.showErrorDialog(context, userData['error']);}
    else
    {
        if(dotenv.env['userType'] == 'HomeOwner'){
          Get.offNamed('/HomePage/HomeOwner');
        }
        else{
          Get.offNamed('/HomePage/ServiceProvider');
        }
    }
  }
}

