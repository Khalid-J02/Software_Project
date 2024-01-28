import 'package:buildnex/screens/Notification/Widgets/Both/customNewMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../APIRequests/notificationsSystem.dart';
import '../../classes/language_constants.dart';

class HomePageNotification extends StatefulWidget {
  const HomePageNotification({super.key});

  @override
  State<HomePageNotification> createState() => _HomePageNotificationState();
}

class _HomePageNotificationState extends State<HomePageNotification> {
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final List<dynamic> fetchedNotifications =
          await NotificationAPI.getNotifications();
      setState(() {
        notifications = fetchedNotifications;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _markAllAsRead(BuildContext context) async {
    try {
      final bool success = await NotificationAPI.markAllNotificationsAsRead();

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(translation(context)!.homepageNotificationShowSnackBar)),
        );
        await _fetchNotifications();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(translation(context)!.homepageNotificationShowSnackBarError)),
        );
      }
    } catch (e) {
      // Handle any errors here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translation(context)!.homepageNotificationShowSnackBarError)),
      );
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 60, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context)!.homepageNotificationsTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _markAllAsRead(context),
                      child: Text(
                        translation(context)!.homepageNotificationsMark,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFF022D6B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    var notification = notifications[index];
                    // Assuming your notification structure has these fields
                    return CustomNewMessageNotification(
                      userPictureUrl: notification['SenderPic'],
                      userName: notification['SenderName'],
                      notificationContent: notification['Content'],
                      IsRead: notification['IsRead'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
