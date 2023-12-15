import 'package:buildnex/screens/Profile.dart';
import 'package:buildnex/screens/projectDesc_HO.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';



void main() {
  runApp(GetMaterialApp(home: ProjectDetailsSP(),));
}


class ProjectDetailsSP extends StatefulWidget {
  const ProjectDetailsSP({super.key});

  @override
  State<ProjectDetailsSP> createState() => _ProjectDetailsSPState();
}

class _ProjectDetailsSPState extends State<ProjectDetailsSP> {

  late String projectId;
  int pageIndex = 0 ;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    final routeArguments = Get.arguments;
    projectId = routeArguments?['projectId'] as String? ?? '';

    screens = [
      ProjectDescription(projectId: projectId),
      ProfilePage(),
    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F4771),
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF3D69B),
        ),
        title: const Text(
          //projectName,
          "Back",
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
                pageIndex = activeIndex ;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.description_sharp,
                text: 'Project Desc.',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'User Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
