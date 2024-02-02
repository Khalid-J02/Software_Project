import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:buildnex/classes/language_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../APIRequests/userRegAPI.dart';
import '../Widgets/customAlertDialog.dart';
import 'package:http/http.dart' as http;

class HomeOwnerRegister extends StatelessWidget {
  const HomeOwnerRegister({super.key});

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
              flex: 3,
              child: Container(
                color: const Color(0xFF122247),
                child: const SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _HomeOwnerRegisterPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}

class _HomeOwnerRegisterPage extends StatefulWidget {
  const _HomeOwnerRegisterPage({super.key});

  @override
  State<_HomeOwnerRegisterPage> createState() =>
      _Forget_PasswordCodePageState();
}

class _Forget_PasswordCodePageState extends State<_HomeOwnerRegisterPage> {
  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController();
  String userLocation = "Your City";

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
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Nablus";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                        translation(context)!.continueRegisterHOUserLocationNablus,
                        style: ElevatedButtonTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Ramallah";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                          translation(context)!.continueRegisterHOUserLocationRamallah,
                          style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Tulkarm";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                          translation(context)!.continueRegisterHOUserLocationTulkarm,
                          style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Qalqilya";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                          translation(context)!.continueRegisterHOUserLocationQalqilya,
                          style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Jenin";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                          translation(context)!.continueRegisterHOUserLocationJenin,
                          style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 930
                        ? 200
                        : 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          userLocation = "Jericho";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text(
                          translation(context)!.continueRegisterHOUserLocationJericho,
                          style: ElevatedButtonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // here will be the functionality for uploading images
  Image? image;
  String? imageUrl;
  late final pickedImage ;
  final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  Future<void> pickImageWEB() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      if (MediaQuery.of(context).size.width > 930) {
        safeSetState;
      } else {
        setState(() {
          image = Image.file(imageFile);
        });
      }
    }
    if (image != null || pickedImage != null) {
      final url = Uri.parse(cloudinaryUrl);
      final req = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'buildnex';

      // Read the image file as bytes
      List<int> imageBytes = await pickedImage.readAsBytes();

      // Convert the image bytes to Uint8List
      Uint8List uint8List = Uint8List.fromList(imageBytes);

      // Create a MultipartFile using fromBytes
      final http.MultipartFile file =
      http.MultipartFile.fromBytes('file', uint8List, filename: 'image.jpg');

      req.files.add(file);

      final response = await req.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'];
          imageUrl = url;
        });
      }
    }
  }

  // Future<void> pickImage() async {
  //   pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     File imageFile = File(pickedImage.path);
  //     MediaQuery.of(context).size.width > 930
  //     ?
  //     safeSetState
  //     :
  //     setState(() {
  //       image = Image.file(imageFile);
  //     });
  //   }
  //   if (image != null || pickedImage != null) {
  //     final url = Uri.parse(cloudinaryUrl) ;
  //     final req = http.MultipartRequest('POST' , url)
  //       ..fields['upload_preset'] = 'buildnex'
  //       ..files.add(await http.MultipartFile.fromPath('file', pickedImage.path)) ;
  //
  //     final response = await req.send();
  //     if(response.statusCode == 200){
  //       final responseData = await response.stream.toBytes() ;
  //       final responseString = String.fromCharCodes(responseData) ;
  //       final jsonMap = jsonDecode(responseString);
  //       setState(() {
  //         final url = jsonMap['url'] ;
  //         imageUrl = url ;
  //       });
  //     }
  //   }
  // }


  // functions from tala
  Map<String, dynamic> UserData_HO() {
    return {
      'image': imageUrl != null ? imageUrl : null,
      'phoneNumber': phoneNumberController.text,
      'city': userLocation,
      'bio': bioController.text,
    };
  }

  bool _areFieldsFilled() {
    Map<String, dynamic> userData = UserData_HO();


    return userData['phoneNumber'].isNotEmpty &&
        userData['city'] != "Your City" &&  userData['image'] != null  &&  userData['bio'].isNotEmpty ;
  }


  void initState() {
    super.initState();
    // Receive the arguments
    Map<String, dynamic> mergedData =
        Get.arguments as Map<String, dynamic>? ?? {};

    phoneNumberController.text = mergedData['phoneNumber'] ?? '';
    userLocation = mergedData['city'] ?? "Your City";
    bioController.text = mergedData['bio'] ?? '';

  }

  Future<void> initializeVariable() async {
    setState(() {
      userLocation = translation(context)!.continueRegisterHOUserLocation ;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
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
              margin: MediaQuery.of(context).size.width > 930
              ?EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 2.5)
              :EdgeInsets.symmetric(
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
            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4,),
            child: ElevatedButton(
              onPressed: () async {
                var imageName = await pickImageWEB(); //pickImage();
              },
              style: ElevatedButtonStyle(),
              child: Text(
                translation(context)!.continueRegisterHOPickProfile,
                style: const TextStyle(
                  color: Color(0xFFF3D69B),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
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
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Color(0xFFF3D69B)),
              decoration: InputDecoration(
                hintText: translation(context)!.continueRegisterHOPhoneNumberHintText,
                hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                filled: true,
                fillColor: Color(0xFF2F4771),
                labelText: translation(context)!.continueRegisterHOPhoneNumber,
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
                side: MaterialStateProperty.all(
                    BorderSide(color: Color(0xFFF3D69B), width: 1)),
                alignment: Alignment.centerLeft,
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                userLocation,
                style: const TextStyle(
                    color: Color(0xFFF3D69B),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Container(
            height: 130,
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
                hintText: translation(context)!.continueRegisterHOBioHintText,
                hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                filled: true,
                fillColor: Color(0xFF2F4771),
                labelText: translation(context)!.continueRegisterHOBio,
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
          SizedBox(
            height:MediaQuery.of(context).size.width > 930
                ? 120
                : 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 38,
                width: 90,
                margin: const EdgeInsets.only(left: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3D69B),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextButton(
                  onPressed: () async {
                    Get.toNamed('/Register',
                        arguments: Map<String, dynamic>.from(
                            {...?Get.arguments, ...UserData_HO()}));
                  },
                  child: Text(
                    translation(context)!.continueRegisterHOBack,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2F4771), //
                    ),
                  ),
                ),
              ),
              Container(
                height: 38,
                width: 90,
                margin: const EdgeInsets.only(right: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF2F4771),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_areFieldsFilled()) {
                      Map<String, dynamic> mergedData =
                          Get.arguments as Map<String, dynamic>? ?? {};

                      Map<String, dynamic> userData = UserData_HO();

                      userRegAPI regAPI = userRegAPI();

                        final reguserData = await regAPI.register(
                            mergedData['firstName'],
                            mergedData['lastName'],
                            "HomeOwner",
                            mergedData['email'],
                            mergedData['password'],
                            mergedData['confirmPassword'],
                            userData['image'], // Image
                            userData['phoneNumber'],
                            userData['city'],
                            "Doesn'tExist", //service Type
                            userData['bio']);

                        if (reguserData.containsKey('error')) {
                          CustomAlertDialog.showErrorDialog(context, reguserData['error']);}
                        else {
                          Get.offNamed('/HomePage/HomeOwner', arguments: {'isNewUser': true});
                        }
                    }

                    else {
                      // Show alert dialog to indicate that Required fields are not filled.
                      CustomAlertDialog.showErrorDialog(context, 'Please fill in all the required fields');

                    }
                  },
                  child: Text(
                    translation(context)!.continueRegisterHOFinish,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFF3D69B),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
