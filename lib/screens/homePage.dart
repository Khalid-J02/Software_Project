
import 'dart:convert';

import 'package:buildnex/Widgets/projectDialog.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/MSG_System/listChatScreen.dart';
import 'package:buildnex/screens/projectNav_homeOwner.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/Widgets/userProjects.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../APIRequests/messageSystem.dart';
import '../APIRequests/notificationsSystem.dart';
import '../Widgets/customAlertDialog.dart';
import 'Notification/homepageNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {

  final bool isNewUser;
  const HomePage({Key? key, this.isNewUser = false}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> usersProject = [];
  int notificationCount = 0;
  int unreadMessageCount = 0;

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey addConstructionsKey = GlobalKey();
  GlobalKey messagesKey = GlobalKey();
  GlobalKey notificationsKey = GlobalKey();
  GlobalKey logoutKey = GlobalKey();


  Future<void> _fetchUnreadMessageCount() async {
    try {
      Map<String, dynamic> responseData =
      await MessagingAPI.getServiceProvidersForHomeowner();


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

  Future<void> updateProjects() async {
    try {
      List<Map<String, dynamic>> projects =
      await HomeOwnerHomePageAPI.getHomeOwnerProjects();
      setState(() {
        usersProject = projects;
      });
    } catch (error) {
      print('Error updating projects: $error');
    }
  }

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

  Future<void> checkAndShowTutorial() async {
    if (widget.isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial1_$userId';
      bool hasShownTutorial = prefs.getBool(tutorialKey) ?? false;


      if (!hasShownTutorial) {
        await Future.delayed(const Duration(seconds: 1));
        await _showTutorialCoachmark();
        await prefs.setBool(tutorialKey, true);
      }
    }
  }

  Future<void> _showTutorialCoachmark() async {
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
        identify: "addConstructions-Key",
        keyTarget: addConstructionsKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Want to start a new project? Tap this '+' icon! It's your gateway to adding new construction projects. Simply tap here, fill in the details of your new project, and watch your construction plans take shape right in the app.",
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
        identify: "messages-Key",
        keyTarget: messagesKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Here's your Messages section! Tap this icon to open your messages, where you can read, respond to, and manage all your conversations.",
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
        identify: "notifications-Key",
        keyTarget: notificationsKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "This is your Notifications bell. Tap it to view all your recent notifications, keeping you updated with alerts and important information.",
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
        identify: "logout-Key",
        keyTarget: logoutKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Tap this logout icon whenever you wish to exit your account securely.",
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
    _fetchUnreadMessageCount();
    _fetchNotifications();
    updateProjects();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          key: addConstructionsKey,
          backgroundColor: Color(0xFFF3D69B),
          onPressed: () async {
            await addNewProject();
          },
          child: const Icon(Icons.add , color: Color(0xFF122247),),
        ),
        appBar: AppBar(
          leading: Icon(Icons.house_outlined , color: Color(0xFFF3D69B),),
          title: Text(
            translation(context)!.homeOwnerHomePageAppBarTitle,
            style: const TextStyle(
                color: Color(0xFFF3D69B)
            ),
          ),
          actions: [
            IconButton(
              key: messagesKey,
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
              key: notificationsKey,
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
              key: logoutKey,
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
      ),
    );
  }
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
