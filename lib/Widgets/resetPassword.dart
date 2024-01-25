import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../APIRequests/userRegAPI.dart';
import '../Widgets/customAlertDialog.dart';
void main() {
  runApp(const Reset_Password());
}

class Reset_Password extends StatelessWidget {
  const Reset_Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: _Reset_PasswordPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}

class _Reset_PasswordPage extends StatefulWidget {
  const _Reset_PasswordPage({super.key});

  @override
  State<_Reset_PasswordPage> createState() => _Reset_PasswordPageState();
}

class _Reset_PasswordPageState extends State<_Reset_PasswordPage> {

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


  late String userId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      userId = arguments['userId'];
    }
  }

  Future<void> _resetPassword() async {
    String newPassword = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      CustomAlertDialog.showErrorDialog(context, 'Please fill in all the required fields');
      return;
    }

    // Call the API to reset the password
    final response = await userRegAPI().resetPassword(userId, newPassword, confirmPassword);

    if (response.containsKey('error')) {
      // Handle error, show alert dialog with error message
      CustomAlertDialog.showErrorDialog(context, response['error']);

    } else if (response.containsKey('message')) {
      CustomAlertDialog.showSuccessDialogforReset(context, response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: MediaQuery.of(context).size.width > 930
                ?
            EdgeInsets.only(top: 30, right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                :
            EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              translation(context)!.resetPasswordMainTitle,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 930
                      ? 27
                      : 24,
                  color: Color(0xFFF3D69B),
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          Padding(
            padding: MediaQuery.of(context).size.width > 930
                ?
            EdgeInsets.only(top: 20 , bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                :
            const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              obscureText: _obsecPass,
              style: TextStyle(color: Color(0xFFF3D69B)),
              decoration: InputDecoration(
                hintText: translation(context)!.resetPasswordPasswordHintText,
                hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                filled: true,
                fillColor: Color(0xFF2F4771),
                labelText: translation(context)!.resetPasswordPassword,
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
          Padding(
            padding: MediaQuery.of(context).size.width > 930
                ?
            EdgeInsets.only(bottom: 5 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                :
            const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obsecConfPass,
              style: TextStyle(color: Color(0xFFF3D69B)),
              decoration: InputDecoration(
                hintText: translation(context)!.resetPasswordConfirmPasswordHintText,
                hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                filled: true,
                fillColor: Color(0xFF2F4771),
                labelText: translation(context)!.resetPasswordConfirmPassword,
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
                    _toggleConfirmPassIcon();
                  },
                  child: Icon(
                    _obsecConfPass
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
            const EdgeInsets.symmetric(vertical: 35, horizontal: 120),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextButton(
              onPressed:_resetPassword,
              child: Text(
                translation(context)!.resetPasswordResetLabel,
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
      ),
    );
  }
}
