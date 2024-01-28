import 'package:buildnex/screens/MSG_System/Widgets/userItem.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../APIRequests/messageSystem.dart';
import '../../classes/language_constants.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListChatScreen> {
  List<UserModel> chatData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  Future<void> _loadChatData() async {
    try {
      var responseData;
      List<dynamic> tempData = [];

      if (dotenv.env['userType'] == 'HomeOwner') {
        responseData = await MessagingAPI.getServiceProvidersForHomeowner();
      } else if (dotenv.env['userType'] == 'ServiceProvider') {
        responseData = await MessagingAPI.getHomeOwnersForServiceProvider();
      }

      if (responseData is Map<String, dynamic>) {
        tempData = responseData['uniqueServiceProviders'] ??
            responseData['uniqueHomeowners'] ??
            [];
      } else if (responseData is List<dynamic>) {
        tempData = responseData;
      } else {
        throw Exception('Invalid data format');
      }

      setState(() {
        chatData = tempData
            .map<UserModel>((item) => UserModel.fromJson(item))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading chat data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          if (dotenv.env['userType'] == 'HomeOwner') {
            Get.offAndToNamed('/HomePage/HomeOwner');
          } else if (dotenv.env['userType'] == 'ServiceProvider') {
            Get.offAndToNamed('/HomePage/ServiceProvider');
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title:  Text(
              translation(context)!.listChatScreenTitle,
              style: TextStyle(color: Color(0xFFF3D69B), fontSize: 22),
            ),
            elevation: 0,
            backgroundColor: Color(0xFF122247), //Colors.white,
          ),
          body: SafeArea(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: chatData.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserItemProfile(user: chatData[index]);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
