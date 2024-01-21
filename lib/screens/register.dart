import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/customAlertDialog.dart';

void main() {
  runApp(const Register());
}

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
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: const Image(
                    image: AssetImage(
                      'images/Proj_Logo_title.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
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
  String serviceType = "Service Type";
  String providerLocation = "Your City";

  final _fncontroller = TextEditingController();
  final _lncontroller = TextEditingController();
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

  TextStyle ElevatedButtonTextStyle() {
    return TextStyle(
        color: Color(0xFFF3D69B), fontSize: 16, fontWeight: FontWeight.normal);
  }

  ButtonStyle ElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center);
  }

  void chooseCityBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery.of(context).size.height / 3,
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Surveyor";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text(
                            "Surveyor",
                            style: ElevatedButtonTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Engineering Office";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Engineering Office",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Constructor";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Constructor",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Plumbing Technician";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Plumbing Technician",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Electrical Technician";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Electrical Technician",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Insulation Technician";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Insulation Technician",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Plasterer";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Plasterer",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Carpenter";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Carpenter",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Tile Contractor";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Tile Contractor",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Painter";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child:
                              Text("Painter", style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              serviceType = "Window Installer";
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Window Installer",
                              style: ElevatedButtonTextStyle()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void providerCityBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Nablus";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                        "Nablus",
                        style: ElevatedButtonTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Ramallah";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Ramallah", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Tulkarm";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Tulkarm", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Qalqilya";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Qalqilya", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Jenin";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jenin", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          providerLocation = "Jericho";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jericho", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // functions from tala

  Map<String, dynamic> UserData() {
    return {
      'firstName': _fncontroller.text,
      'lastName': _lncontroller.text,
      'role': _dropDownValue,
      'email': _emailController.text,
      'password': _passwordController.text,
      'confirmPassword': _confirmPasswordController.text,
    };
  }

  bool _areFieldsFilled() {
    Map<String, dynamic> userData = UserData();

    return userData['firstName'].isNotEmpty &&
        userData['lastName'].isNotEmpty &&
        userData['role'] != 'Your Role' &&
        userData['email'].isNotEmpty &&
        userData['password'].isNotEmpty &&
        userData['confirmPassword'].isNotEmpty;
  }

  void initState() {
    super.initState();

    // Receive the arguments
    Map<String, dynamic> mergedData =
        Get.arguments as Map<String, dynamic>? ?? {};
    print(mergedData);

    _fncontroller.text = mergedData['firstName'] ?? '';
    _lncontroller.text = mergedData['lastName'] ?? '';
    _dropDownValue = mergedData['role'] ?? 'Your Role';
    _emailController.text = mergedData['email'] ?? '';
    _passwordController.text = mergedData['password'] ?? '';
    _confirmPasswordController.text = mergedData['confirmPassword'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          height: 70,
          padding: MediaQuery.of(context).size.width > 930
            ?
              EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
            :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: _fncontroller,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your first name here',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'First Name',
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
          height: 70,
          padding: MediaQuery.of(context).size.width > 930
            ?
              EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
            :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: _lncontroller,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your last name here',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Last Name',
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
          height: 70,
          padding: MediaQuery.of(context).size.width > 930
            ?
              EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
            :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2F4771),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Color(0xFFF3D69B)),
            ),
            child: DropdownButton<String>(
              value: _dropDownValue,
              icon: const Icon(
                Icons.arrow_downward,
                color: Color(0xFFF3D69B),
              ),
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
                    margin: MediaQuery.of(context).size.width > 930
                      ?
                        EdgeInsets.fromLTRB(12, 0, MediaQuery.of(context).size.width / 3, 0)
                      :
                    const EdgeInsets.fromLTRB(12, 0, 245, 0),
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
                  value: 'Service Provider',
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    child: const Text('Service Provider'),
                  ),
                )
              ],
              dropdownColor: const Color(0xFF2F4771),
            ),
          ),
        ),
        Container(
          height: 70,
          padding: MediaQuery.of(context).size.width > 930
            ?
              EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
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
        Container(
          height: 70,
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
          height: 70,
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            onPressed: () async {
              if (_areFieldsFilled()) {
                // Print the data for testing
                Map<String, dynamic> userData = UserData();

                Map<String, dynamic> mergedData =
                    Get.arguments as Map<String, dynamic>? ?? {};

                if (_dropDownValue == 'Home Owner') {
                  Get.toNamed('/Register/HomeOwner', arguments: {
                    ...userData,
                    'phoneNumber': mergedData['phoneNumber'],
                    'city': mergedData['city'],
                    'bio': mergedData['bio'],
                    'image': mergedData['image'],
                  });
                }
                else if (_dropDownValue == 'Service Provider') {
                  Get.toNamed('/Register/ServiceProvider', arguments: {
                    ...userData,
                    'phoneNumber': mergedData['phoneNumber'],
                    'city': mergedData['city'],
                    'serviceType': mergedData['serviceType'],
                    'bio': mergedData['bio'],
                    'image': mergedData['image'],
                  });
                }
                else {
                  // do nothing (stay on the same page)
                }
              } else {
                // Show alert dialog to indicate that Required fields are not filled.
                CustomAlertDialog.showErrorDialog(
                    context, 'Please fill in all the required fields');
              }
            },
            child: Text(
              'Continue',
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
              'Already have an account? ',
              style: TextStyle(color: Color(0xFFF3D69B) ,
                fontSize: MediaQuery.of(context).size.width > 930
                    ? 17
                    : 15,
              ),
            ),
            TextButton(
              onPressed: () {
                // go to login page
                Get.offNamed('/Login');
              },
              child: Text(
                'Login',
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
}
