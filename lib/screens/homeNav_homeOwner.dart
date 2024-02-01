import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/Profile.dart';
import 'package:buildnex/screens/homePage.dart';
import 'package:buildnex/screens/searchPage_HO.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';

void main() {
  runApp(const NavBarHomeOwner());
}

class NavBarHomeOwner extends StatefulWidget {
  const NavBarHomeOwner({super.key});

  @override
  State<NavBarHomeOwner> createState() => _NavBarHomeOwnerState();
}

class _NavBarHomeOwnerState extends State<NavBarHomeOwner> {
  late int pageIndex ;
  late List<Widget> screens;
  late bool isNewUser;


  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    isNewUser = args['isNewUser'] ?? false;
    pageIndex = args['pageIndex'] ?? 0;
    screens = [
      HomePage(isNewUser: isNewUser),
      SearchPage(
        askForRequest: false,
        isNewUser: isNewUser,
      ),
      ProfilePage(isNewUser: isNewUser),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF2F4771),
          body: screens[pageIndex],
          bottomNavigationBar: Container(
            color: const Color(0xFF122247),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              child: GNav(
                selectedIndex: pageIndex,
                gap: 8,
                backgroundColor: const Color(0xFF122247),
                color: const Color(0xFFF3D69B),
                activeColor: const Color(0xFFF3D69B),
                tabBackgroundColor: const Color(0xFF2F4991),
                padding: const EdgeInsets.all(16),
                onTabChange: (activeIndex) {
                  setState(() {
                    pageIndex = activeIndex;
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: translation(context)!.homeNavHomeOwnerHomeIcon,
                  ),
                  GButton(
                    icon: Icons.search,
                    text: translation(context)!.homeNavHomeOwnerSearchIcon,
                  ),
                  GButton(
                    icon: Icons.account_circle_outlined,
                    text: translation(context)!.homeNavHomeOwnerProfileIcon,
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
