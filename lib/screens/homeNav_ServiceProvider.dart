import 'package:buildnex/screens/MSG_System/listChatScreen.dart';
import 'package:buildnex/screens/serviceProviderAssets.dart';
import 'package:buildnex/screens/serviceProviderCatalog.dart';
import 'package:buildnex/screens/serviceProviderProfile.dart';
import 'package:buildnex/screens/serviceProviderRequests.dart';
import 'package:buildnex/screens/serviceProviderTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:buildnex/classes/language_constants.dart';

void main() {
  runApp(GetMaterialApp(
    home: NavBarServiceProvider(),
  ));
}

class NavBarServiceProvider extends StatefulWidget {
  const NavBarServiceProvider({super.key});

  @override
  State<NavBarServiceProvider> createState() => _NavBarServiceProviderState();
}

class _NavBarServiceProviderState extends State<NavBarServiceProvider> {
  late int pageIndex;
  late List<Widget> screens;
  late bool isNewUser;

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey tasksKey = GlobalKey();
  GlobalKey requestsKey = GlobalKey();
  GlobalKey catalogKey = GlobalKey();
  GlobalKey workExpKey = GlobalKey();
  GlobalKey profileKey = GlobalKey();

  Future<void> checkAndShowTutorial() async {
    if (isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial5_$userId';
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
        print("${target.identify}");
      },
      hideSkip: true,
      onFinish: () {
        print("FinishHomePage");
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      TargetFocus(
        identify: "tasks-Key",
        keyTarget: tasksKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.homeNavServiceProviderTasksKey,
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
        identify: "requests-Key",
        keyTarget: requestsKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.homeNavServiceProviderRequestsKey,
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
        identify: "catalog-Key",
        keyTarget: catalogKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.homeNavServiceProviderCatalogKey,
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
        identify: "workExp-Key",
        keyTarget: workExpKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.homeNavServiceProviderWorkExpKey,
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
        identify: "profile-Key",
        keyTarget: profileKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.homeNavServiceProviderProfileKey,
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
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    isNewUser = args['isNewUser'] ?? false;
    pageIndex = args['pageIndex'] ?? 0;
    screens = [
      ServiceProviderTasks(),
      ServiceProviderRequests(isNewUser: isNewUser),
      ServiceProviderCatalog(isNewUser: isNewUser),
      ServiceProviderAssets(isNewUser: isNewUser),
      ServiceProviderProfilePage(isNewUser: isNewUser),
    ];
    checkAndShowTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: GNav(
                selectedIndex: pageIndex,
                gap: 20,
                backgroundColor: Color(0xFF122247),
                color: Color(0xFFF3D69B),
                activeColor: Color(0xFFF3D69B),
                tabBackgroundColor: Color(0xFF2F4991),
                padding: EdgeInsets.all(12),
                onTabChange: (activeIndex) {
                  setState(() {
                    pageIndex = activeIndex;
                  });
                },
                tabs: [
                  GButton(
                    key: tasksKey,
                    icon: Icons.paste,
                    text: translation(context)!.homeNavServiceProviderTasksIcon,
                  ),
                  GButton(
                    key: requestsKey,
                    icon: Icons.question_answer_sharp,
                    text: translation(context)!.homeNavServiceProviderRequestsIcon,
                  ),
                  GButton(
                    key: catalogKey,
                    icon: Icons.folder_copy,
                    text: translation(context)!.homeNavServiceProviderCatalogIcon,
                  ),
                  GButton(
                    key: workExpKey,
                    icon: Icons.work,
                    text: translation(context)!.homeNavServiceProviderWorkExpIcon,
                  ),
                  GButton(
                    key: profileKey,
                    icon: Icons.account_circle_outlined,
                    text: translation(context)!.homeNavServiceProviderProfileIcon,
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
    return Directionality(
    textDirection: Localizations.localeOf(context).languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: AnimatedBuilder(
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
                ElevatedButton(
                  onPressed: widget.onNext,
                  child: Text(translation(context)!.coachmarkNext),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: widget.onSkip,
                  child: Text(translation(context)!.coachmarkSkip),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}
