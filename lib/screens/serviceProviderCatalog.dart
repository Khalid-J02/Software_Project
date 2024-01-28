import 'package:buildnex/screens/serviceProviderCatalogItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../APIRequests/serviceProviderCatalogAPI.dart';
import '../Widgets/addCatalogNewItem.dart';
import '../Widgets/sp_CatalogItem.dart';
import '../classes/language_constants.dart';

class ServiceProviderCatalog extends StatefulWidget {
  final bool isNewUser;
  const ServiceProviderCatalog({super.key, this.isNewUser = false});

  @override
  State<ServiceProviderCatalog> createState() => _ServiceProviderCatalogState();
}

class _ServiceProviderCatalogState extends State<ServiceProviderCatalog> {
  List<Map<String, dynamic>> jsonList = [];

  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey addCatalogKey = GlobalKey();

  Future<void> _loadCatalogItems() async {
    try {
      final fetchedCatalogItems = await CatalogAPI.getCatalogItems();
      setState(() {
        jsonList = fetchedCatalogItems;
      });
    } catch (e) {
      // Handle API call errors
      print('Error loading catalog items: $e');
    }
  }

  Future<List<dynamic>?> addNewItem() => showDialog<List<dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return CatalogNewItem();
      });

  Future<void> checkAndShowTutorial() async {
    if (widget.isNewUser) {
      final prefs = await SharedPreferences.getInstance();
      String userId = dotenv.env['userID'] ?? 'defaultUser';
      String tutorialKey = 'hasShownTutorial7_$userId';
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
        identify: "addCatalog-Key",
        keyTarget: addCatalogKey,
        color: Color(0xFF070000),
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: translation(context)!.serviceProviderCatalogPageKey,
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
            Icons.folder_copy,
            color: Color(0xFFF3D69B),
          ),
          title: Text(
            translation(context)!.serviceProviderCatalogMainTitle,
            style: TextStyle(color: Color(0xFFF3D69B)),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          key: addCatalogKey,
          backgroundColor: Color(0xFFF9FAFB),
          onPressed: () async {
            List<dynamic>? newData = await addNewItem();

            setState(() {
              if (newData != null) {
                Map<String, dynamic> jsonObject = {
                  "ItemImage": newData[4], //"images/Testing/Tokyo.jpg",
                  "ItemName": newData[0],
                  "ItemPrice": newData[2],
                  "ItemRating": 0.0,
                  "CatalogID": newData[5]
                };
                jsonList.add(jsonObject);
              }
            });
          },
          child: const Icon(
            Icons.add,
            color: Color(0xFF122247),
            size: 25,
          ),
        ),
        body: jsonList.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      translation(context)!.serviceProviderCatalogText,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            : GridView.builder(
                itemCount: jsonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 930 ? 5 : 2,
                ),
                itemBuilder: (context, index) {
                  var ItemObject = jsonList[index];
                  return GestureDetector(
                      onTap: () async {
                        final Map<String, dynamic> itemDetails =
                            await CatalogAPI.getItemDetails(
                                ItemObject["CatalogID"].toString());
                        Get.to(
                            () => (SPCatalogItem(
                                catalogID: ItemObject["CatalogID"].toString())),
                            arguments: itemDetails);
                      },
                      child: ServiceProvideCatalogItem(
                        catalogItemImageURL: ItemObject["ItemImage"].toString(),
                        catalogItemImageName: ItemObject["ItemName"],
                        catalogItemPrice: ItemObject["ItemPrice"].toDouble(),
                        catalogItemRating: ItemObject["ItemRating"].toDouble(),
                      ));
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
