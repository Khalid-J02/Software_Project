import 'dart:convert';
import 'dart:io';

import 'package:buildnex/Widgets/profileData.dart';
import 'package:buildnex/Widgets/userProfileDataDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buildnex/APIRequests/profilePageHomeOwnerAPI.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/customAlertDialog.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: const ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String userRole = '';

  String userEmail = '';
  String userBio = '';
  String userPhoneNum = '';
  late String userPic = '';

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

  @override
  void initState() {
    super.initState();
    // Load the profile data when the screen initializes
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFF122247),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            List<String>? updatedData = await editProfile();
                            if (updatedData != null) {
                              // Call the API to update the profile in the database
                              final response = await HomeOwnerProfilePageAPI
                                  .editProfile({
                                'UserPhoneNumber': updatedData[0],
                                'Email': updatedData[1],
                                'UserProfileInfo': updatedData[2],
                              });
                              if (response.containsKey('message')) {
                                setState(() {
                                  userPhoneNum = updatedData[0];
                                  userEmail = updatedData[1];
                                  userBio = updatedData[2];
                                });
                              }
                              else if (response.containsKey('error')) {
                              CustomAlertDialog.showErrorDialog(context, response['error']);
                              }
                            }
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Color(0xFFF3D69B),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: const Color(0xFF2F4771),
                    width: MediaQuery.of(context).size.width,
                    child: ProfileData(
                      userName: userName,
                      userRole: userRole,
                      userPhone: userPhoneNum,
                      userEmail: userEmail,
                      userBio: userBio,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 7,
              left: MediaQuery.of(context).size.width / 3,
              right: MediaQuery.of(context).size.width / 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFF3D69B),
                    width: 5,
                  ),
                  shape: BoxShape.circle,
                ),
                child:  CircleAvatar(
                  radius: 65,
                  backgroundImage: userPic.isNotEmpty
                      ? NetworkImage(userPic) as ImageProvider<Object>?
                      : AssetImage("images/profilePic96.png") as ImageProvider<Object>?,
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.width / 6,
              left: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 4,
              child: GestureDetector(
                onTap: () async {
                  await pickImage() ;
                  /*
                  all you need to do is to send the image url variable to the database and store there.
                   */
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[500],
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Color(0xFFF3D69B),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await HomeOwnerProfilePageAPI.getProfile();
      setState(() {
        userName = profile['Username'];
        userRole = profile['UserType'];
        userEmail = profile['Email'];
        userBio = profile['UserProfileInfo'];
        userPhoneNum = profile['PhoneNumber'];
        userPic = profile['UserPicture'];

      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<List<String>?> editProfile() => showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return UserProfileDataDialog(
          phoneNumber: userPhoneNum,
          eMail: userEmail,
          bio: userBio,
        );
      });
}
