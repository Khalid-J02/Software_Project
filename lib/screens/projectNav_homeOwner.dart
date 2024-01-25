import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/projectDesc_HO.dart';
import 'package:buildnex/screens/projectTasks_HO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() {
  runApp(const ProjectNavBar());
}

class ProjectNavBar extends StatefulWidget {
  const ProjectNavBar({Key? key}) : super(key: key);

  @override
  State<ProjectNavBar> createState() => _ProjectNavBarState();
}

class _ProjectNavBarState extends State<ProjectNavBar> {

  late String projectId;
  int pageIndex = 0 ;

  late List<Widget> screens;

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey tasksKey = GlobalKey();
  GlobalKey projectInfoKey = GlobalKey();

  Future<void> checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    String userId = dotenv.env['userID'] ?? 'defaultUser';
    String tutorialKey = 'hasShownTutorial4_$userId';
    bool hasShownTutorial = prefs.getBool(tutorialKey) ?? false;
    if (!hasShownTutorial) {
      await Future.delayed(const Duration(seconds: 1));
      await _showTutorialCoachmark();
      await prefs.setBool(tutorialKey, true);
    }
  }

  Future<void> _showTutorialCoachmark() async {
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      pulseEnable: false,
      colorShadow: const Color(0xE4FFFFFF),
      onClickTarget: (target) {
      },
      hideSkip: true,
      onFinish: () {
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
                "Use the 'Tasks' tab to view and manage all the tasks associated with your construction. It provides a comprehensive list of things to do, helping you track construction progress, and individual task details. Stay organized and on top of your construction tasks here.",
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
        identify: "projectInfo-Key",
        keyTarget: projectInfoKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                "Tap the 'Description' tab to access detailed information about your construction.",
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
    checkAndShowTutorial();
    super.initState();
    final routeArguments = Get.arguments;
    projectId = routeArguments?['projectId'] as String? ?? '';


    screens = [
      ProjectTasksHomeOwner(projectId: projectId),
      ProjectDescription(projectId: projectId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF2F4771),
        appBar: AppBar(
          title: Text(
            //projectName,
            translation(context)!.homeOwnerProjectNavAppBarTitle,
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),

        body: screens[pageIndex],

        bottomNavigationBar: Container(

          color: const Color(0xFF122247),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 12),
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
              tabs: [
                GButton(
                  key: tasksKey,
                  icon: Icons.paste,
                  text: translation(context)!.homeOwnerProjectNavTasksIcon,
                ),
                GButton(
                  key: projectInfoKey,
                  icon: Icons.info,
                  text: translation(context)!.homeOwnerProjectNavDescriptionIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;
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

