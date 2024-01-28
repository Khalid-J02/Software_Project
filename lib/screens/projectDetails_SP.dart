import 'package:buildnex/screens/seeDetailsProfile_SP.dart';
import 'package:buildnex/screens/seeDetailsRequest_SP.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

import '../classes/language_constants.dart';

void main() {
  runApp(GetMaterialApp(
    home: ProjectDetailsSP(),
  ));
}

class ProjectDetailsSP extends StatefulWidget {
  const ProjectDetailsSP({super.key});

  @override
  State<ProjectDetailsSP> createState() => _ProjectDetailsSPState();
}

class _ProjectDetailsSPState extends State<ProjectDetailsSP> {
  late String projectId;
  late String taskId;
  late String taskNumber;
  late String homeownerId;

  int pageIndex = 0;
  late List<Widget> screens;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;

    projectId = arguments['projectId'];
    taskId = arguments['taskId'];
    taskNumber = arguments['taskNumber'];
    homeownerId = arguments['HomeOwnerId'];

    screens = [
      ProjectDescriptionSeeDetails(
        projectId: projectId,
        taskId: taskId,
        taskNumber: taskNumber,
      ),
      SeeDetailsProfilePage(homeownerId: homeownerId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF2F4771),
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFF3D69B),
          ),
          title: Text(
            translation(context)!.serviceProviderAssetsItemDetailsTitle,
            style: TextStyle(color: Color(0xFFF3D69B)),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: screens[pageIndex],
        bottomNavigationBar: Container(
          color: const Color(0xFF122247),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: GNav(
              gap: 8,
              backgroundColor: Color(0xFF122247),
              color: Color(0xFFF3D69B),
              activeColor: Color(0xFFF3D69B),
              tabBackgroundColor: Color(0xFF2F4991),
              padding: EdgeInsets.all(16),
              onTabChange: (activeIndex) {
                setState(() {
                  pageIndex = activeIndex;
                });
              },
              tabs:  [
                GButton(
                  icon: Icons.description_sharp,
                  text: translation(context)!.projectDetails_SP_Des,
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                  text: translation(context)!.projectDetails_SP_HO,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
