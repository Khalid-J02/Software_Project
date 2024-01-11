import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../APIRequests/userRegAPI.dart';
import '../Widgets/customAlertDialog.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



class ServiceProviderRegister extends StatelessWidget {
  const ServiceProviderRegister({super.key});



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
                flex: 3,
                child: Container(
                  color: const Color(0xFF122247),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _ServiceProviderRegisterPage(),
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

class _ServiceProviderRegisterPage extends StatefulWidget {

  const _ServiceProviderRegisterPage({super.key});

  @override
  State<_ServiceProviderRegisterPage> createState() => _ServiceProviderRegisterPageState();
}

class _ServiceProviderRegisterPageState extends State<_ServiceProviderRegisterPage> {

  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController() ;
  String userLocation = "Your City" ;
  String serviceType = "Service Type" ;

  TextStyle ElevatedButtonTextStyle(){
    return TextStyle(
        color: Color(0xFFF3D69B),
        fontSize: 16,
        fontWeight: FontWeight.normal
    );
  }
  ButtonStyle ElevatedButtonStyle(){
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center
    ) ;
  }

  void chooseCityBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery.of(context).size.height/3,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Nablus" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Nablus" , style: ElevatedButtonTextStyle(),),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Ramallah" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Ramallah" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Tulkarm" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Tulkarm" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Qalqilya" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Qalqilya" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Jenin" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jenin" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          userLocation = "Jericho" ;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jericho" , style: ElevatedButtonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void chooseServiceTypeBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery.of(context).size.height/3,
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Surveyor" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Surveyor" , style: ElevatedButtonTextStyle(),),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Engineering Office" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Engineering Office" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Constructor" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Constructor" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Plumbing Technician" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Plumbing Technician" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Electrical Technician" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Electrical Technician" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Insulation & HVAC Contractors" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Insulation & HVAC Contractors" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Plasterer" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Plasterer" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Carpenter" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Carpenter" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Tile Contractor" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Tile Contractor" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Painter" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Painter" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              serviceType = "Window Installer" ;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButtonStyle(),
                          child: Text("Window Installer" , style: ElevatedButtonTextStyle()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Image? image;
  String? imageUrl;
  late final pickedImage ;
  final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  Future<void> pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      setState(() {
        image = Image.file(imageFile);
      });
    }
    if (image != null) {
      final url = Uri.parse(cloudinaryUrl) ;
      final req = http.MultipartRequest('POST' , url)
        ..fields['upload_preset'] = 'buildnex'
        ..files.add(await http.MultipartFile.fromPath('file', pickedImage.path)) ;

      final response = await req.send();
      if(response.statusCode == 200){
        final responseData = await response.stream.toBytes() ;
        final responseString = String.fromCharCodes(responseData) ;
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'] ;
          imageUrl = url ;
        });
      }
    }
  }

  // functions from tala
  Map<String, dynamic> UserData_SP() {
    return {
      'image': imageUrl != null ? imageUrl : null,
      'phoneNumber': phoneNumberController.text,
      'city': userLocation,
      'serviceType': serviceType,
      'bio': bioController.text,
    };
  }

  bool _areFieldsFilled() {
    Map<String, dynamic> userData = UserData_SP();

    return userData['phoneNumber'].isNotEmpty &&
           userData['city'] != "Your City" &&
           userData['serviceType']!= "Service Type";
  }

  void initState() {
    super.initState();

    // Receive the arguments
    Map<String, dynamic> mergedData =
        Get.arguments as Map<String, dynamic>? ?? {};

    print(mergedData);
    phoneNumberController.text = mergedData['phoneNumber'] ?? '';
    userLocation = mergedData['city'] ?? "Your City";
    serviceType =mergedData['serviceType'] ?? "Service Type";
    bioController.text = mergedData['bio'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if(imageUrl == null)
          Container(
            height: 210 ,
            child: Center(
              child: Icon(Icons.image , color: Color(0xFFF3D69B), size: 35,),
            ),
          ),
        if (imageUrl != null)
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4),
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(30),
                child: pickedImage == null
                    ? const Icon(
                  Icons.image,
                  size: 35,
                  color: Color(0xFFF3D69B),
                )
                    : Image.network(
                  imageUrl!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        Container(
          // padding: const EdgeInsets.only(left: 8.0),
          margin: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/2.5 , left: MediaQuery.of(context).size.width/2.5)
              :
          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4,),

          child: ElevatedButton(
            onPressed: () async{
              var imageName = await pickImage() ;
            },
            style: ElevatedButtonStyle(),
            child: const Text(
              "Pick Ptofile Picture",
              style: TextStyle(
                color: Color(0xFFF3D69B),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Container(
          height:70,
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your Phone Number here',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Phone Number',
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
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          height: 70,
          child: ElevatedButton(
            onPressed: chooseCityBottomSheet,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF2F4771)),
              elevation: MaterialStateProperty.all(0),
              side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
              alignment: Alignment.centerLeft,
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text(userLocation,
              style: const TextStyle(
                  color: Color(0xFFF3D69B),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ),
        Container(
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          height: 70,
          child: ElevatedButton(
            onPressed: chooseServiceTypeBottomSheet,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF2F4771)),
              elevation: MaterialStateProperty.all(0),
              side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
              alignment: Alignment.centerLeft,
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: Text(serviceType,
              style: const TextStyle(
                  color: Color(0xFFF3D69B),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
        ),
        Container(
          height:130,
          padding: MediaQuery.of(context).size.width > 930
              ?
          EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
              :
          const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: bioController,
            style: TextStyle(color: Color(0xFFF3D69B)),
            decoration: InputDecoration(
              hintText: 'Enter your bio here',
              hintStyle: TextStyle(color: Color(0xFFF3D69B)),
              filled: true,
              fillColor: Color(0xFF2F4771),
              labelText: 'Your Bio',
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
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
            ),
          ),
        ),
        // SizedBox(height: 60,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 35,
              width: 90,
              margin: const EdgeInsets.only(left: 12 ,),
              decoration: const BoxDecoration(
                color: Color(0xFFF3D69B),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextButton(
                onPressed: () async {
                  Get.toNamed('/Register',
                      arguments: Map<String, dynamic>.from(
                          {...?Get.arguments, ...UserData_SP()}));
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
              margin: const EdgeInsets.only(right: 12 ,),
              decoration: const BoxDecoration(
                color: Color(0xFF2F4771),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: TextButton(
                onPressed: () async {
                  if (_areFieldsFilled()) {
                    Map<String, dynamic> mergedData =
                        Get.arguments as Map<String, dynamic>? ?? {};

                    Map<String, dynamic> userData = UserData_SP();

                    print(mergedData['firstName']);
                    print(mergedData['lastName']);
                    print(mergedData['role']);
                    print(mergedData['email']);
                    print(mergedData['password']);
                    print(mergedData['confirmPassword']);

                    print(userData);

                    userRegAPI regAPI = userRegAPI();

                    final reguserData = await regAPI.register(
                        mergedData['firstName'],
                        mergedData['lastName'],
                        "ServiceProvider",
                        mergedData['email'],
                        mergedData['password'],
                        mergedData['confirmPassword'],
                        "", // Image
                        userData['phoneNumber'],
                        userData['city'],
                        userData['serviceType'], //service Type
                        userData['bio']);

                    if (reguserData.containsKey('error')) {
                      CustomAlertDialog.showErrorDialog(context, reguserData['error']);}
                    else {
                      Get.offNamed('/HomePage/ServiceProvider');}
                  }

                  else {
                    // Show alert dialog to indicate that Required fields are not filled.
                    CustomAlertDialog.showErrorDialog(context, 'Please fill in all the required fields');

                  }
                },
                child: const Text(
                  'Finish',
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
