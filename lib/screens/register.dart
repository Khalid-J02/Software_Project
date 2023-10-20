
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() {
//   runApp(const Register());
// }

class Register extends StatelessWidget {
  const Register({super.key});

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
                  color: const Color(0xFF122247), // 0xFFcce2e6
                  child: SingleChildScrollView(
                    child: const _RegisterPage(),
                    scrollDirection: Axis.vertical,
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

class _RegisterPage extends StatefulWidget {
  const _RegisterPage({super.key});

  @override
  State<_RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<_RegisterPage> {

  String _dropDownValue = 'Your Role';


  final _fncontroller = TextEditingController();
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: _fncontroller,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your name here',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Full Name',
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2F4771),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Color(0xFFF3D69B)),
            ),
            child: DropdownButton<String>(
              value: _dropDownValue,
              icon: const Icon(Icons.arrow_downward , color: Color(0xFFF3D69B),),
              style: const TextStyle(
                color: Color(0xFFF3D69B),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _dropDownValue = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Your Role',
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 245, 0),
                    child: const Text('Your Role'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Home Owner',
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    child: const Text('Home Owner'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Engineering Office',
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    child: const Text('Engineering Office'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Service Provider',
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    child: const Text('Service Provider'),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obsecConfPass,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'confirm your password ...',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Confirm Password',
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
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: TextButton(
            onPressed: () {

              // here will be post request to add new user to the system(DB)

              Get.toNamed('/Login');
              // Get.to(HomePage());
            },
            child: const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Already have an account? ' , style: TextStyle(color: Color(0xFFF3D69B)),),
            TextButton(
              onPressed: () {
                // go to login page
                Get.toNamed('/Login');
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFF3D69B),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
