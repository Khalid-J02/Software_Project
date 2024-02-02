import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:buildnex/Widgets/profileData.dart';
import 'package:buildnex/Widgets/userProfileDataDialog.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:buildnex/APIRequests/profilePageHomeOwnerAPI.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/customAlertDialog.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void main() {
  runApp(MaterialApp(home: const ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  final bool isNewUser;
  const ProfilePage({super.key, this.isNewUser = false});


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

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey editProfileInfoKey = GlobalKey();
  GlobalKey editProfileImageKey = GlobalKey();

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

  Future<void> checkAndShowTutorial() async {
    if (widget.isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial3_$userId';
      bool hasShownTutorial = prefs.getBool(tutorialKey) ?? false;
      if (!hasShownTutorial) {
        await Future.delayed(const Duration(seconds: 1));
        await _showTutorialCoachmark();
        await prefs.setBool(tutorialKey, true);
      }
    }
  }

  Future<void> _showTutorialCoachmark() async  {
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
      colorShadow: const Color(0xE4FFFFFF),
      onClickTarget: (target) {
      },
      hideSkip: true,
      //alignSkip: Alignment.center,
      onFinish: () {
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      TargetFocus(
        identify: "editProfileInfo-Key",
        keyTarget: editProfileInfoKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Edit your profile information here. Tap this icon to update your personal details such as your phone number, email, and a short bio. Keeping your profile updated ensures better communication and personalization.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),


      TargetFocus(
        identify: "editProfileImage-Key",
        keyTarget: editProfileImageKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Personalize your profile by updating your profile picture. Tap here to choose and upload a new image. This picture represents you in the app and helps others recognize you easily.",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),


    ];
  }

  @override
  void initState() {
    checkAndShowTutorial();
    super.initState();
    _loadProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFF122247),
                    padding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: MediaQuery.of(context).size.width > 930
                        ? 40
                        : 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          key: editProfileInfoKey,
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
              top: MediaQuery.of(context).size.width > 930
                  ?
              70
                  :
              MediaQuery.of(context).size.width / 7,
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
                  radius: MediaQuery.of(context).size.width > 930
                      ? 75
                      : 65,
                  backgroundImage: userPic.isNotEmpty
                      ? NetworkImage(userPic) as ImageProvider<Object>?
                      : AssetImage("images/profilePic96.png") as ImageProvider<Object>?,
                ),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).size.width > 930
                  ?
              80
                  :
              MediaQuery.of(context).size.width / 6,
              left: MediaQuery.of(context).size.width > 930
                  ?
              MediaQuery.of(context).size.width / 3 - 40
                  :
              MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 4,
              child: GestureDetector(
                key: editProfileImageKey,
                onTap: () async {
                  await pickImageWEB() ;
                  await HomeOwnerProfilePageAPI.editUserProfileImage(imageUrl!);
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
    ) ;
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


class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext,
  });


  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;


  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}


class _CoachmarkDescState extends State<CoachmarkDesc>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;


  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 20,
      duration: const Duration(milliseconds: 800),
    )..repeat(min: 0, max: 20, reverse: true);
    super.initState();
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animationController.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.onSkip,
                  child: Text(widget.skip),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: widget.onNext,
                  child: Text(widget.next),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

