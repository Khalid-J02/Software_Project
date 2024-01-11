import 'package:buildnex/Widgets/forgotPasswordCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../APIRequests/userRegAPI.dart';
import '../Widgets/customAlertDialog.dart';


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
                    image: AssetImage('images/Proj_Logo_title.png'),
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
  late String userEmailArg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      userEmailArg= arguments['userEmail'];
      if(_emailController.text.isEmpty)
        {
          _emailController.text=userEmailArg;
        }
    }
  }


  Future<void> _forgotPassword() async {
    String email = _emailController.text;

    if (email.isEmpty) {
      // Show an alert dialog if the email is empty
      CustomAlertDialog.showErrorDialog(context, 'Please enter your email');
      return;
    }

    // Call the API to initiate the password reset
      final response = await userRegAPI().forgotPassword(email);

      if (response.containsKey('error')) {
        // Handle error, show alert dialog with error message
        CustomAlertDialog.showErrorDialog(context, response['error']);
      }
      else {
        // Password reset initiated successfully, navigate to ForgotPassCode
        print(response['userId']);

        Get.toNamed('/ForgotPassCode', arguments: {'userId': response['userId'],'userEmail':email});
      }

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 30, right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Find Your BuildNex Account",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 930
                  ? 27
                  : 22,
                color: Color(0xFFF3D69B),
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        Padding(
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(bottom: 5 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Text(
            "Enter the email associated with your account to change your password",
            style: TextStyle(
                fontSize:MediaQuery.of(context).size.width > 930
                    ? 18
                    : 14,
                color: Color(0xFFF3D69B),
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        Padding(
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 30, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
          margin: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 20, bottom: 10 , right: MediaQuery.of(context).size.width/2.5 , left: MediaQuery.of(context).size.width/2.5)
              :
          const EdgeInsets.symmetric(vertical: 35, horizontal: 120),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: TextButton(
            onPressed: _forgotPassword,
            child: Text(
              'Reset Password',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 930
                    ? 19
                    : 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
