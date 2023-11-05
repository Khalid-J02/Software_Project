import 'package:buildnex/screens/serviceProviderProfile.dart';
import 'package:buildnex/screens/serviceProviderRequests.dart';
import 'package:buildnex/screens/serviceProviderTasks.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(MaterialApp(home: NavBarServiceProvider(),));
}

class NavBarServiceProvider extends StatefulWidget {
  const NavBarServiceProvider({super.key});

  @override
  State<NavBarServiceProvider> createState() => _NavBarServiceProviderState();
}

class _NavBarServiceProviderState extends State<NavBarServiceProvider> {

  int pageIndex = 0 ;
  final screens = [
    ServiceProviderTasks(),
    ServiceProviderRequests(),
    // here should go the page for catalog we will design it tmw, this will bring the catalog of products sp have and will give him ability to edit it by adding a new pic new item and remove and also update.
    ServiceProviderProfilePage(),

  ];


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

      body: ServiceProviderRequests() ,//ServiceProviderTasks() ,//screens[pageIndex],

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
                icon: Icons.paste,
                text: 'Tasks',
              ),
              GButton(
                icon: Icons.question_answer_sharp,
                text: 'Requests',
              ),
              GButton(
                icon: Icons.folder_copy,
                text: 'Catalog',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
