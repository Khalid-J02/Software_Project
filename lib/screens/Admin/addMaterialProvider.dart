import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../APIRequests/adminSystem.dart';

class AddMaterialProvider extends StatefulWidget {
  const AddMaterialProvider({super.key});

  @override
  State<AddMaterialProvider> createState() => _AddMaterialProviderState();
}

class _AddMaterialProviderState extends State<AddMaterialProvider> {
  String selectedServiceType = 'Select Service Type';
  String selectedCity = 'Select City';
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController socialLinkController = TextEditingController();


  final List<String> serviceTypes = [
    'Constructor',
    'Carpenter',
    'Tile Contractor',
    'Window Installer',
    'Painter',
    'Finishing'
  ];


  final List<String> cities = [
    'Nablus',
    'Ramallah',
    'Tulkarm',
    'Qalqilya',
    'Jenin',
    'Jericho'
  ];


  ButtonStyle ElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF2F4771),
        ),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center);
  }

  Image? image;
  String? imageUrl;
  late final pickedImage;
  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
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

  Future<void> submitMaterialProvider() async {
    if (selectedServiceType == 'Select Service Type' ||
        selectedCity == 'Select City' ||
        companyNameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        socialLinkController.text.isEmpty ||
        imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      var response = await AdminAPI.addMatirealProvider(
        companyNameController.text,
        'MaterialProvider',
        imageUrl!,
        selectedCity,
        selectedServiceType,
        socialLinkController.text,
        phoneNumberController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Material provider added successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        companyNameController.clear();
        socialLinkController.clear();
        phoneNumberController.clear();
        selectedServiceType = 'Select Service Type';
        selectedCity = 'Select City';
        imageUrl = null;
      });

    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add material provider. Error: $exception'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Icon(
          Icons.person_add_rounded,
          color: Color(0xFFF3D69B),
        ),
        title: const Text(
          'Add Material Provider',
          style: TextStyle(color: Color(0xFFF3D69B)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      backgroundColor: Colors.grey[300],
    body: SingleChildScrollView(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              "Enter the following fields :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF122247),
              ),
            ),
          ),
          if (imageUrl == null)
            Container(
              height: 210,
              child: const Center(
                child: Icon(
                  Icons.image,
                  color: Color(0xFFF3D69B),
                  size: 35,
                ),
              ),
            ),
          if (imageUrl != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 80),
                  height: 210,
                  width: 250,
                  decoration: const BoxDecoration(
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
              ],
            ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                var imageName = await pickImageWEB();
              },
              style: ElevatedButtonStyle(),
              child: const Text(
                "Pick Picture",
                style: TextStyle(
                  color: Color(0xFFF3D69B),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Company Name:",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF122247),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 70,
                  padding: MediaQuery.of(context).size.width > 930
                      ? EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: MediaQuery.of(context).size.width / 3.5,
                          left: MediaQuery.of(context).size.width / 3.5)
                      : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextFormField(
                    controller: companyNameController,
                    style: TextStyle(color: Color(0xFFF3D69B)),
                    decoration: InputDecoration(
                      hintText: 'Enter here..',
                      hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                      filled: true,
                      fillColor: Color(0xFF2F4771),
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
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Social Link : ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF122247),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 70,
                  padding: MediaQuery.of(context).size.width > 930
                      ? EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: MediaQuery.of(context).size.width / 3.5,
                          left: MediaQuery.of(context).size.width / 3.5)
                      : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextFormField(
                    controller: socialLinkController,
                    style: TextStyle(color: Color(0xFFF3D69B)),
                    decoration: InputDecoration(
                      hintText: 'Enter here..',
                      hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                      filled: true,
                      fillColor: Color(0xFF2F4771),
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
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Phone Number : ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFF122247),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  height: 70,
                  padding: MediaQuery.of(context).size.width > 930
                      ? EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: MediaQuery.of(context).size.width / 3.5,
                      left: MediaQuery.of(context).size.width / 3.5)
                      : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: TextFormField(
                    controller: phoneNumberController,
                    style: TextStyle(color: Color(0xFFF3D69B)),
                    decoration: InputDecoration(
                      hintText: 'Enter here..',
                      hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                      filled: true,
                      fillColor: Color(0xFF2F4771),
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
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Service Type : ",
                    style: TextStyle(fontSize: 17, color: Color(0xFF122247)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  padding: MediaQuery.of(context).size.width > 930
                      ? EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: MediaQuery.of(context).size.width / 3.5,
                          left: MediaQuery.of(context).size.width / 3.5)
                      : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Select Service Type',
                      hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                      filled: true,
                      fillColor: Color(0xFF2F4771),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFF3D69B)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFF3D69B)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    value: selectedServiceType != 'Select Service Type'
                        ? selectedServiceType
                        : null,
                    onChanged: (newValue) {
                      setState(() {
                        selectedServiceType = newValue!;
                      });
                    },
                    items: serviceTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(color: Color(0xFFF3D69B))),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xFFF3D69B)),
                    iconSize: 24,
                    dropdownColor: Color(0xFF2F4771),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "City : ",
                    style: TextStyle(fontSize: 17, color: Color(0xFF122247)),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 70,
                  padding: MediaQuery.of(context).size.width > 930
                      ? EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: MediaQuery.of(context).size.width / 3.5,
                          left: MediaQuery.of(context).size.width / 3.5)
                      : const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: 'Select City',
                      hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                      filled: true,
                      fillColor: Color(0xFF2F4771),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFF3D69B)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Color(0xFFF3D69B)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    value: selectedCity != 'Select City' ? selectedCity : null,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity = newValue!;
                      });
                    },
                    items: cities.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(color: Color(0xFFF3D69B))),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xFFF3D69B)),
                    iconSize: 24,
                    dropdownColor: Color(0xFF2F4771),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: ElevatedButton(
              onPressed: submitMaterialProvider,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2F4771), // background (button) color
                onPrimary: Color(0xFFF3D69B), // foreground (text) color
                minimumSize: Size(double.infinity, 50), // set the minimum size
                padding: EdgeInsets.symmetric(horizontal: 0), //// inner padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // match your TextField border radius
                  side: BorderSide(color: Color(0xFFF3D69B)), // border color
                ),
              ),
              child: const Text(
                'Add Material Provider',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
