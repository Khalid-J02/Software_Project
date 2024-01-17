import 'package:buildnex/screens/Notification/Widgets/Both/customNewMessage.dart';
import 'package:buildnex/screens/Notification/Widgets/HomeOwner/CustomRequestAccept.dart';
import 'package:buildnex/screens/Notification/Widgets/HomeOwner/CustomRequestDenied.dart';
import 'package:buildnex/screens/Notification/Widgets/HomeOwner/customTaskCompleted.dart';
import 'package:buildnex/screens/Notification/Widgets/ServiceProvider/customReviewAdded.dart';
import 'package:buildnex/screens/Notification/Widgets/ServiceProvider/customReviewUpdated.dart';
import 'package:buildnex/screens/Notification/Widgets/ServiceProvider/customTaskRequest.dart';
import 'package:flutter/material.dart';


class HomePageNotification extends StatefulWidget {
  const HomePageNotification({super.key});

  @override
  State<HomePageNotification> createState() => _HomePageNotificationState();
}

class _HomePageNotificationState extends State<HomePageNotification> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF022D6B),
                  ),
                ),
                CustomRequestAcceptNotification(),
                CustomRequestDeniedNotification(),
                CustomNewMessageNotification() ,
                CustomReviewAddedNotification(),
                CustomReviewUpdatedNotification(),
                CustomTaskRequestNotification(),
                CustomTaskCompletedNotification(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
