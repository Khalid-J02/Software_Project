
import 'package:buildnex/Widgets/serviceProviderData.dart';
import 'package:buildnex/Widgets/serviceProviderProfileDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/profilePageServiceProviderAPI.dart';
import '../Widgets/customAlertDialog.dart';

void main() {
  runApp(MaterialApp(home: const ServiceProviderProfilePage()));
}

class ServiceProviderProfilePage extends StatefulWidget {
  const ServiceProviderProfilePage({super.key});

  @override
  State<ServiceProviderProfilePage> createState() => _ServiceProviderProfilePageState();
}

class _ServiceProviderProfilePageState extends State<ServiceProviderProfilePage> {

  String userName = '';
  String userRole = '' ;

  String userEmail = '';
  String userBio = '' ;
  String userPhoneNum = '';

  double userRating = 0.0 ;
  int userPrice = 0 ;
  late String userPic = '';


  @override
  void initState() {
    super.initState();
    // Load the profile data when the screen initializes
    _loadProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color(0xFF122247),
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                             onTap: () async {
                               List<String>? updatedData = await editProfile();
                               if (updatedData != null) {
                                 final response = await ServiceProviderProfilePageAPI.editProfile({
                                   'UserPhoneNumber': updatedData[0],
                                   'Email': updatedData[1],
                                   'UserProfileInfo': updatedData[2],
                                   'Price': int.parse(updatedData[3]),
                                 });

                                 if (response.containsKey('message')) {
                                   setState(() {
                                     userPhoneNum = updatedData[0];
                                     userEmail = updatedData[1];
                                     userBio = updatedData[2];
                                     userPrice = int.parse(updatedData[3]);
                                   });
                                 } else if (response.containsKey('error')) {
                                   CustomAlertDialog.showErrorDialog(context, response['error']);
                                 }
                               }
                             },
                            child: const Icon(Icons.edit, color: Color(0xFFF3D69B),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: const Color(0xFF2F4771),
                      width: MediaQuery.of(context).size.width,
                      child:SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ServiceProviderData(userName: userName, userEmail: userEmail , userRole: userRole, userBio: userBio, userPhone: userPhoneNum, userPrice: userPrice, userRating: userRating,),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.width / 12,
                left: MediaQuery.of(context).size.width / 3 ,
                right: MediaQuery.of(context).size.width / 3 ,
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
                        ? AssetImage(userPic)
                        : AssetImage("images/profilePic96.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  // Functions from Tala
  Future<void> _loadProfile() async {
    try {
      final profile = await ServiceProviderProfilePageAPI.getProfile();
      setState(() {
        userName = profile['Username'];
        userRole = profile['UserType'];
        userEmail = profile['Email'];
        userBio = profile['UserProfileInfo'];
        userPhoneNum = profile['PhoneNumber'];
        userRating = double.parse(profile['Rating'].toString());
        userPrice = int.parse(profile['Price'].toString());
        userPic = profile['UserPicture'];
      });
    } catch (e) {
      print('Error loading profile: $e');
    }
  }
  Future<List<String>?> editProfile() => showDialog<List<String>>(
    context: context,
    builder: (BuildContext context) {
      return ServiceProviderProfileDataDialog(
        phoneNumber: userPhoneNum,
        eMail: userEmail,
        bio: userBio,
        pricePerHour: userPrice,
      );
    },
  );

}
