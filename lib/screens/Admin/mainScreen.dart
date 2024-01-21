import 'package:buildnex/screens/Admin/addMaterialProvider.dart';
import 'package:buildnex/screens/Admin/homePageAdmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MainAdminPage ());
}

class MainAdminPage extends StatefulWidget {
  const MainAdminPage({super.key});

  @override
  State<MainAdminPage> createState() => _MainAdminPageState();
}

class _MainAdminPageState extends State<MainAdminPage> {

  int pageIndex = 0 ;
  final screens = [
    HomePageAdmin(),
    AddMaterialProvider(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // final shouldPop = await showDialog<bool>(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: Text('Are you sure?'),
        //     content: Text('Do you want to Logout?'),
        //     actions: [
        //       TextButton(
        //         onPressed: () => Navigator.of(context).pop(false),
        //         child: Text('No'),
        //       ),
        //       TextButton(
        //         onPressed: () => Navigator.of(context).pop(true),
        //         child: Text('Yes'),
        //       ),
        //     ],
        //   ),
        // );
        // return shouldPop ?? false; // Default to false if dialog is dismissed
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: screens[pageIndex],
          bottomNavigationBar: Container(
            color: const Color(0xFF122247),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50 , vertical: 10),
              child: GNav(
                gap: 8,
                backgroundColor: const Color(0xFF122247),
                color: const Color(0xFFF3D69B),
                activeColor: const Color(0xFFF3D69B),
                tabBackgroundColor: const Color(0xFF2F4991),
                padding: const EdgeInsets.all(12),
                onTabChange: (activeIndex) {
                  setState(() {
                    pageIndex = activeIndex ;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.analytics,
                    text: 'Statistics',
                  ),
                  GButton(
                    icon: Icons.person_add_rounded,
                    text: 'Add',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
