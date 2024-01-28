import 'package:buildnex/APIRequests/serviceProviderWorkExpAPI.dart';
import 'package:buildnex/Widgets/addAssetNewItem.dart';
import 'package:buildnex/Widgets/serviceProviderAssetsItemDetails.dart';
import 'package:buildnex/Widgets/sp_AssetsItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../classes/language_constants.dart';


class ServiceProviderAssets extends StatefulWidget {
  final bool isNewUser;
  const ServiceProviderAssets({super.key,this.isNewUser = false});

  @override
  State<ServiceProviderAssets> createState() => _ServiceProviderAssetsState();
}


class _ServiceProviderAssetsState extends State<ServiceProviderAssets> {

  List<Map<String, dynamic>> workList = [];
  Map<String, dynamic> jsonObject = {};

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey addWorkExpKey = GlobalKey();

  Future <List<dynamic>?> addNewItem () => showDialog <List<dynamic>>(
      context: context,
      builder: (BuildContext context){
        return AssetNewItem() ;
      }
  ) ;

  Future<void> _loadCatalogItems() async {
    try {
      final List<Map<String, dynamic>> providerWorkExp = await WorkExperienceAPI.getWorkExperiences() ;
      setState(() {
        workList = providerWorkExp;
      });
    } catch (e) {
      // Handle API call errors
      print('Error loading catalog items: $e');
    }
  }

  Future<void> checkAndShowTutorial() async {
    if (widget.isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial8_$userId';
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
      },
      hideSkip: true,
      //alignSkip: Alignment.center,
      onFinish: () {
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      TargetFocus(
        identify: "addWorkExp-Key",
        keyTarget: addWorkExpKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.serviceProviderAssetsPageKey,
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
    _loadCatalogItems();
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
          Icons.work,
          color: Color(0xFFF3D69B),
        ),
        title: Text(
          translation(context)!.serviceProviderAssetsMainTitle,
          style: TextStyle(color: Color(0xFFF3D69B)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        key: addWorkExpKey,
        backgroundColor: Color(0xFFF9FAFB),
        onPressed: () async {
          List<dynamic>? newData = await addNewItem() ;
          setState(() {
            if(newData != null){
              jsonObject = {
                "WorkImage": newData[2],
                "WorkName" : newData[0],
                'WorkDescription' : newData[1],
                'WorkID' : newData[3]
              };
              workList.add(jsonObject);
            }
          });
        },
        child: const Icon(
          Icons.add , color: Color(0xFF122247),
          size: 25,
        ),
      ),
      body: workList.length == 0
          ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              translation(context)!.serviceProviderAssetsText,
              style: TextStyle(
                  color: Colors.grey[600] ,
                  fontSize: 18 , fontWeight:
              FontWeight.bold
              ),
            ),
          )
        ],
      )
          :
      GridView.builder(
        itemCount: workList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 930
              ? 5
              : 2,
        ),
        itemBuilder: (context , index){
          var ItemObject = workList[index];
          return GestureDetector(
            onTap: () async{
              final Map<String, dynamic> itemDetails = await WorkExperienceAPI.getWorkExpDetails(ItemObject["WorkID"].toString());
              Get.to(() => (SPAssetsItem(ItemID: ItemObject["WorkID"].toString())) , arguments:itemDetails);
            },
            child: ServiceProvideAssetsItem(catalogItemImageURL: ItemObject["WorkImage"].toString(), catalogItemImageName: ItemObject["WorkName"],),
          );
        },
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
