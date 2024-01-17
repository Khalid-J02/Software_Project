import 'package:buildnex/screens/Notification/homepageNotification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainNotificationPage ());
}

class MainNotificationPage extends StatelessWidget {
  const MainNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageNotification(),
    );
  }
}
