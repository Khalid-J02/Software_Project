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


void main() {
  runApp(GetMaterialApp(home: NavBarServiceProvider(),));
}

class NavBarServiceProvider extends StatefulWidget {
  const NavBarServiceProvider({super.key});

  @override
  State<NavBarServiceProvider> createState() => _NavBarServiceProviderState();
}

class _NavBarServiceProviderState extends State<NavBarServiceProvider> {

  int pageIndex = 0 ;
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

  Future<void> _showTutorialCoachmark() async{
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
                text:
                "Welcome to the Tasks tab! Here, you can effectively manage and track all the tasks you are currently working on. This tab provides a comprehensive view of your ongoing projects, allowing you to organize your workload and stay on top of your commitments.",
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
                text:
                "This is the Requests tab. In this section, you'll receive job requests from homeowners. You have the flexibility to accept tasks that align with your schedule and expertise or decline them as needed. It's your one-stop hub for managing incoming work inquiries and planning your workload.",                onNext: () {
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
                text:
                "Explore the Catalog tab! As a service provider, this is your space to showcase the services you offer. If you're a painter, for example, you can display various color options and related services here. It's a great way to let potential clients know what you have to offer and attract more business.",
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
                text:
                "Discover the Work Experience tab. Here, you can display your past projects and highlight your achievements. It's an excellent opportunity to showcase your skills and experience, giving potential clients a glimpse of your expertise and the quality of work you deliver.",
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
                text:
                "Welcome to the Profile Page! Here, you can easily view and update your personal details and preferences. This is your hub for ensuring your profile information is accurate and up-to-date, making it easier for service providers and other users to connect with you.",
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
    return WillPopScope(
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
              gap: 20,
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
              tabs: [
                GButton(
                  key: tasksKey,
                  icon: Icons.paste,
                  text: 'Tasks',
                ),
                GButton(
                  key: requestsKey,
                  icon: Icons.question_answer_sharp,
                  text: 'Requests',
                ),
                GButton(
                  key: catalogKey,
                  icon: Icons.folder_copy,
                  text: 'Catalog',
                ),
                GButton(
                  key: workExpKey,
                  icon: Icons.work,
                  text: 'Work Exp.',
                ),
                GButton(
                  key: profileKey,
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
    return AnimatedBuilder(
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
                TextButton(
                  onPressed: widget.onSkip,
                  child: Text(widget.skip),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: widget.onNext,
                  child: Text(widget.next),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

