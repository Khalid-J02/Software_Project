import 'package:buildnex/screens/Profile.dart';
import 'package:buildnex/screens/forgot_Password.dart';
import 'package:buildnex/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const NavBarHomeOwner());
}

class NavBarHomeOwner extends StatefulWidget {
  const NavBarHomeOwner({super.key});

  @override
  State<NavBarHomeOwner> createState() => _NavBarHomeOwnerState();
}

class _NavBarHomeOwnerState extends State<NavBarHomeOwner> {

  int pageIndex = 0 ;
  final screens = [
    HomePage(),
    Forget_Password(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF2F4771),
        // body: SafeArea(
        //   child:
        // ),
        body: screens[pageIndex],
        bottomNavigationBar: Container(
          color: const Color(0xFF122247),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0 , vertical: 12),
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
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
