import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../Widgets/sp_RequestsDetails.dart';
import '../APIRequests/serviceProviderRequestsAPI.dart';
import '../classes/language_constants.dart';

class ServiceProviderRequests extends StatefulWidget {
  final bool isNewUser;
  const ServiceProviderRequests({super.key, this.isNewUser = false});

  @override
  State<ServiceProviderRequests> createState() =>
      _ServiceProviderRequestsState();
}

class _ServiceProviderRequestsState extends State<ServiceProviderRequests> {
  List<Map<String, dynamic>> serviceProviderRequests = [];

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey requestsKey = GlobalKey();

  void _removeproject(String projectName) {
    setState(() {
      serviceProviderRequests
          .removeWhere((request) => request['projectName'] == projectName);
    });
  }

  Future<void> _loadRequests() async {
    try {
      final requests = await RequestsAPI.getAllRequests();
      setState(() {
        serviceProviderRequests = requests;
      });
    } catch (e) {
      // Handle the error
      print('Error loading requests: $e');
    }
  }

  Future<void> checkAndShowTutorial() async {
    if (widget.isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial6_$userId';
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
      //alignSkip: Alignment.center,
      onFinish: () {
        print("FinishHomePage");
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      TargetFocus(
        identify: "requests-Key",
        keyTarget: requestsKey,
        color: Color(0xFF070000),
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(
              top: MediaQuery.of(context).size.height * 0.6,
              right: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
            ),
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.serviceProviderRequestPageKey,
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
    _loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.question_answer_sharp,
            color: Color(0xFFF3D69B),
          ),
          title: Text(
            //projectName,
            translation(context)!.serviceProviderRequestsMainTitle,
            style: TextStyle(color: Color(0xFFF3D69B)),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: SafeArea(
          child: Container(
            key: requestsKey,
            color: Color(0xFF2F4771),
            child: ListView.builder(
              itemCount: serviceProviderRequests.length,
              itemBuilder: (context, index) {
                final request = serviceProviderRequests[index];
                return SPRequestDetails(
                  taskProjectName: request['projectName'],
                  taskHomeOwnerName: request['homeOwnerName'],
                  taskProjectId: request['projectId'].toString(),
                  taskHomeOwnerId: request['homeOwnerId'].toString(),
                  requestId: request['requestId'].toString(),
                  taskId: request['taskId'].toString(),
                  taskNumber: request['taskNumber'].toString(),
                  removeProject: _removeproject,
                );
              },
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
