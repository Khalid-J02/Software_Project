
import 'dart:convert';

import 'package:buildnex/Widgets/projectDialog.dart';
import 'package:buildnex/screens/MSG_System/listChatScreen.dart';
import 'package:buildnex/screens/projectNav_homeOwner.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/Widgets/userProjects.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';
import 'package:get/get.dart';

import '../APIRequests/messageSystem.dart';
import '../APIRequests/notificationsSystem.dart';
import '../Widgets/customAlertDialog.dart';
import 'Notification/homepageNotification.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> usersProject = [];
  int notificationCount = 0;
  int unreadMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUnreadMessageCount();
    _fetchNotifications();
    updateProjects();
  }


  Future<void> _fetchUnreadMessageCount() async {
    try {
      Map<String, dynamic> responseData = await MessagingAPI.getServiceProvidersForHomeowner();

      if (responseData.containsKey('unreadConversationsCount')) {
        unreadMessageCount = responseData['unreadConversationsCount'];
      } else {
        throw Exception('unreadConversationsCount key not found in response');
      }

      setState(() {
        // Update your state if necessary
      });
    } catch (e) {
      print('Error fetching unread message count: $e');
    }
  }

  Future<void> _fetchNotifications() async {
    try {
      int count = await NotificationAPI.getNotificationCount();
      setState(() {
        notificationCount = count;
      });
    } catch (e) {
      print(e);
    }
  }


      // create new project
  Future<void> addNewProject() async {
    Map<String, dynamic>? newProject = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return ProjectDialog();
      },
    );

    if (newProject != null) {
      // Update the UI with the new list of projects
      setState(() {
        usersProject.add({
          'projectId': newProject['projectId'],
          'projectName': newProject['projectName'],
          'projectStatus': 'Not Started',
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white, //#abcdd2 chose this color instead
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF3D69B),
        onPressed: () async {
          await addNewProject();
        },
        child: const Icon(Icons.add , color: Color(0xFF122247),),
      ),
      appBar: AppBar(
        leading: Icon(Icons.house_outlined , color: Color(0xFFF3D69B),),
        title: const Text(
          'Your Constructions',
          style: TextStyle(
              color: Color(0xFFF3D69B)
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Icon(Icons.message, color: Color(0xFFF3D69B), size: 24),
                if (unreadMessageCount > 0) // Only show if count is greater than 0
                  Positioned(
                    right: -3.2,
                    top: -3.2,
                    child: Container(
                      padding: EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 13,
                        minHeight: 13,
                      ),
                      child: Text(
                        '$unreadMessageCount', // Show the count here
                        style: TextStyle(
                          color:Color(0xFFF3D69B),
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Get.offNamed('/Messages');
            },
          ),
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Icon(Icons.notifications, color: Color(0xFFF3D69B) , size: 24),
                if (notificationCount > 0) // Only show if count is greater than 0
                  Positioned(
                    right: -3.2,
                    top: -3.2,
                    child: Container(
                      padding: EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 13,
                        minHeight: 13,
                      ),
                      child: Text(
                        '$notificationCount', // Show the count here
                        style: TextStyle(
                          color: Color(0xFFF3D69B),
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Get.offNamed('/Notifications');
            },

          ),
          IconButton(
            icon: Icon(Icons.logout , color: Color(0xFFF3D69B) , size: 24,), // Choose your preferred icon
            onPressed: () async {
              bool? shouldLogout = await CustomAlertDialog.showLogoutConfirmationDialog(context);
             if (shouldLogout == true) {
               Get.offAllNamed('/');

             }
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xFF122247),//Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFF2F4771), // 0xFF42747B
          child: ListView.builder(
            itemCount: usersProject.length,
            itemBuilder: (context, index) {
              return UserProjects(
                projectId: usersProject[index]['projectId'].toString(),
                projectName: usersProject[index]['projectName'],
                projectStatus: usersProject[index]['projectStatus'].toString(),
              );
            },
          ),
        ),
      ),
    );
  }

  //Functions from Tala
  Future<void> updateProjects() async {
    try {
      List<Map<String, dynamic>> projects = await HomeOwnerHomePageAPI.getHomeOwnerProjects();
      setState(() {
        usersProject = projects;
      });
    } catch (error) {
      print('Error updating projects: $error');
    }
  }
}