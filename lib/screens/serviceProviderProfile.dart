
import 'dart:convert';
import 'dart:io';

import 'package:buildnex/Widgets/serviceProviderData.dart';
import 'package:buildnex/Widgets/serviceProviderProfileDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../APIRequests/profilePageServiceProviderAPI.dart';
import '../APIRequests/serviceProviderReviewsAPI.dart';
import '../Widgets/customAlertDialog.dart';
import 'package:buildnex/Widgets/reviewTab.dart';

import 'package:http/http.dart' as http;

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
  late List<Map<String, dynamic>> reviewList ;

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
    _loadProfile();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      final response = await ReviewsAPI.getAllReviews();
        setState(() {
          reviewList = response;
        });
    } catch (e) {
      print('Error loading reviews: $e');
    }
  }

  void _showReviewsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service Provider Reviews'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: reviewList.length,
              itemBuilder: (BuildContext context, int index) {
                final review = reviewList[index];
                      return SPReviews(
                        imageURL: review["HomeOwnerPicture"],
                        name: review["HomeOwnerName"],
                        rating: review["Rating"].toDouble(),
                        date: review["ReviewDate"],
                        reviewText: review["ReviewContent"],
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFF122247),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  // Expanded(
                  //   flex: 3,
                  //   child: ListView.builder(
                  //     itemCount: reviewList.length,
                  //     itemBuilder: (context, index) {
                  //       final review = reviewList[index];
                  //       return SPReviews(
                  //         imageURL: review["HomeOwnerPicture"],
                  //         name: review["HomeOwnerName"],
                  //         rating: review["Rating"].toDouble(),
                  //         date: review["ReviewDate"],
                  //         reviewText: review["ReviewContent"],
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.width / 25,
                left: MediaQuery.of(context).size.width / 25,
                child: GestureDetector(
                  onTap: _showReviewsDialog, // Invoke the reviews dialog function
                  child: const Icon(
                    Icons.reviews, // You can choose any icon that represents "reviews" for you
                    color: Color(0xFFF3D69B),
                  ),
                ),
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
                        ? NetworkImage(userPic) as ImageProvider<Object>?
                        : AssetImage("images/profilePic96.png") as ImageProvider<Object>?,
                  ),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.width / 9,
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
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
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
