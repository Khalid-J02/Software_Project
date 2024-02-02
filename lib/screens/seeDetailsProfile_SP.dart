import 'package:buildnex/Widgets/profileData.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/APIRequests/profilePageHomeOwnerAPI.dart';
import 'package:http/http.dart' as http;

import '../APIRequests/serviceProviderRequestsAPI.dart';
import '../classes/language_constants.dart';

class SeeDetailsProfilePage extends StatefulWidget {
  final String homeownerId;

  const SeeDetailsProfilePage({required this.homeownerId, super.key});

  @override
  State<SeeDetailsProfilePage> createState() => _SeeDetailsProfilePageState();
}

class _SeeDetailsProfilePageState extends State<SeeDetailsProfilePage> {
  String userName = '';
  String userRole = '';

  String userEmail = '';
  String userBio = '';
  String userPhoneNum = '';
  late String userPic = '';

  Image? image;
  String? imageUrl;
  late final pickedImage;
  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  @override
  void initState() {
    super.initState();
    // Load the profile data when the screen initializes
    _loadProfile();
  }

  @override
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xFF122247),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 60),
                  ),
                ),
                Expanded(
                  flex: 9,
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
                  ? 65
                  : MediaQuery.of(context).size.width / 10,
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
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: userPic.isNotEmpty
                      ? NetworkImage(userPic) as ImageProvider<Object>?
                      : AssetImage("images/profilePic96.png")
                          as ImageProvider<Object>?,
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
      final profile = await RequestsAPI.getProfilefromID(widget.homeownerId);
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
}
