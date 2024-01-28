import 'package:buildnex/Widgets/serviceProvideCard_HO.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Widgets/Categories_HO.dart';
import '../Widgets/CustomSearchDelegate.dart';
import '../Widgets/customAlertDialog.dart';
import '../Widgets/filterSearch_HO.dart';

import '../APIRequests/homeOwnerSearchAPI.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class SearchPage extends StatefulWidget {
  final bool askForRequest;
  final bool isNewUser;

  const SearchPage({super.key, required this.askForRequest, this.isNewUser = false});


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

 late Map<String, dynamic> serviceTypeArgument;

  late List<Map<String, dynamic>> serviceProviders = []; // getBestFourServiceProviders

  final _searchController = TextEditingController();
  String activeCategory = '';
  late String taskID ;

  final List<Map<String, dynamic>> categoryList = [
    {
      "serviceName": "Surveyor",
      "Icon": Icons.landscape,
    },
    {
      "serviceName": "Engineering Office",
      "Icon": Icons.desk,
    },
    {
      "serviceName": "Constructor",
      "Icon": Icons.construction,
    },
    {
      "serviceName": "Plumbing Technician",
      "Icon": Icons.plumbing,
    },
    {
      "serviceName": "Electrical Technician",
      "Icon": Icons.electric_bolt_outlined,
    },
    {
      "serviceName": "Insulation Technician",
      "Icon": Icons.hvac,
    },
    {
      "serviceName": "Carpenter",
      "Icon": Icons.carpenter,
    },
    {
      "serviceName": "Plasterer",
      "Icon": Icons.format_paint_outlined,
    },
    {
      "serviceName": "Tile Contractor",
      "Icon": Icons.person_outlined,
    },
    {
      "serviceName": "Window Installer",
      "Icon": Icons.window_rounded,
    },
    {
      "serviceName": "Painter",
      "Icon": Icons.format_paint_sharp,
    },
  ];

 TutorialCoachMark? tutorialCoachMark;
 List<TargetFocus> targets = [];


 GlobalKey searchKey = GlobalKey();
 GlobalKey filterKey = GlobalKey();
 GlobalKey servicesKey = GlobalKey();
 GlobalKey discoverKey = GlobalKey();


 void selectedCategory(String selectedCategory) {
    setState(() {
      activeCategory = selectedCategory;
    });
    if (activeCategory.isNotEmpty)
    {
      _getServiceProvidersByServiceType(activeCategory);
    }
    else
      {
        _getBestServiceProviders();

      }
  }

  int filterRating = 1;
  int filterMinWage = 10;
  int filterMaxWage = 200;
  String filterSPLocation = "";

  Future<List<String>?> filterSearch() => showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return FilterSearch(
          activeCategory: activeCategory,
          filterRating: filterRating,
          filterSPLocation: filterSPLocation,
          filterMinWage: filterMinWage,
          filterMaxWage: filterMaxWage,
        );
      });


  Future<void> _filterServiceProviders() async {
    try {
      List<Map<String, dynamic>> filteredProviders;

      // Check if an active category is selected
      if (activeCategory.isNotEmpty) {

        if (filterSPLocation.isNotEmpty) {
          filteredProviders = await HomeOwnerSearchAPI.filterServiceProviders(
            rating: filterRating.toDouble(),
            minPrice: filterMinWage.toDouble(),
            maxPrice: filterMaxWage.toDouble(),
            city: filterSPLocation,
            serviceType: activeCategory,
          );
           filterRating = 1;
           filterMinWage = 10;
           filterMaxWage = 200;
           filterSPLocation = "";
        }
        else {
          CustomAlertDialog.showErrorDialog(
              context, 'Filter for Service Provider Location is Empty');
          return;
        }
      } else {
        // If no active category, filter on all service providers

        // Ensure filterSPLocation is not empty before making the API call
        if (filterSPLocation.isNotEmpty) {
          filteredProviders = await HomeOwnerSearchAPI.filterServiceProviders(
            rating: filterRating.toDouble(),
            minPrice: filterMinWage.toDouble(),
            maxPrice: filterMaxWage.toDouble(),
            city: filterSPLocation,
          );
          filterRating = 1;
          filterMinWage = 10;
          filterMaxWage = 200;
          filterSPLocation = "";

        } else {
          CustomAlertDialog.showErrorDialog(
              context, 'Filter for Service Provider Location is Empty');
          return;
        }
      }

      setState(() {
        serviceProviders = filteredProviders;
      });
    } catch (e) {
      print('Error filtering service providers: $e');
    }
  }

 Future<void> checkAndShowTutorial() async {
   if (widget.isNewUser) {
     final prefs = await SharedPreferences.getInstance();
     String userId = dotenv.env['userID'] ?? 'defaultUser';
     String tutorialKey = 'hasShownTutorial2_$userId';
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
       identify: "search-Key",
       keyTarget: searchKey,
       color: Color(0xFF070000),
       shape: ShapeLightFocus.RRect,
       contents: [
         TargetContent(
           align: ContentAlign.bottom,
           builder: (context, controller) {
             return CoachmarkDesc(
               text:
               "Use this search bar to find service providers by name. Type your query and select from the suggestions or submit the search to see the results.",
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
       identify: "filter-Key",
       keyTarget: filterKey,
       color: Color(0xFF070000),
       contents: [
         TargetContent(
           align: ContentAlign.bottom,
           builder: (context, controller) {
             return CoachmarkDesc(
               text:
               "Tap this icon to apply filters on your search. You can filter service providers based on ratings, wage range, location, and more to find the perfect match for your needs.",
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
       identify: "services-Key",
       keyTarget: servicesKey,
       color: Color(0xFF070000),
       shape: ShapeLightFocus.RRect,
       contents: [
         TargetContent(
           align: ContentAlign.bottom,
           builder: (context, controller) {
             return CoachmarkDesc(
               text:
               "Explore a variety of services right at your fingertips. In this section, you can browse through different service categories like Surveyor, Constructor, Carpenter, and more. Tap on any category to view service providers specialized in that field. It's an easy way to narrow down your search and find exactly what you need!",
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
       identify: "discover-Key",
       keyTarget: discoverKey,
       color: Color(0xFF070000),
       shape: ShapeLightFocus.RRect,
       contents: [
         TargetContent(
           align: ContentAlign.custom,
           customPosition: CustomTargetContentPosition(
             top: MediaQuery.of(context).size.height * 0.65,
             right: MediaQuery.of(context).size.width * 0.1,
             bottom: MediaQuery.of(context).size.height * 0.1,
             left: MediaQuery.of(context).size.width * 0.1,
           ),
           padding : EdgeInsets.all(5.0),
           builder: (context, controller) {
             return CoachmarkDesc(
               text:
               "Welcome to the Discover section! Here, we've handpicked the best service providers from each category for you. It's a great starting point to find top-rated and reliable professionals. Browse through this curated list to discover skilled service providers and select the perfect one for your project needs.",
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

    if(widget.askForRequest == true ){
      setState(() {
        serviceTypeArgument= Get.arguments;
        activeCategory = serviceTypeArgument['servicetype'];
        taskID = serviceTypeArgument['TaskID'] ;
      });
    }
    else{
      setState(() {
        activeCategory = '' ;
        taskID = '' ;
      });
    }

    // Call the API to get the best service providers
    if(widget.askForRequest == true){
      _getServiceProvidersByServiceType(serviceTypeArgument['servicetype']);
    }
    else {
      _getBestServiceProviders();
    }
  }

  Future<void> _getServiceProvidersByServiceType(String serviceType) async {
    try {
      final List<Map<String, dynamic>> providers =
      await HomeOwnerSearchAPI.getServiceProvidersByServiceType(
          serviceType);

      setState(() {
        serviceProviders = providers;
        // print(serviceProviders) ;
      });
    } catch (e) {
      print('Error fetching service providers by service type: $e');
    }
  }

  Future<void> _getBestServiceProviders() async {
    try {
      final List<Map<String, dynamic>> bestServiceProviders =
          await HomeOwnerSearchAPI.getBestFourServiceProviders();

      setState(() {
        serviceProviders = bestServiceProviders;
        // print('In the search: $serviceProviders');
      });
    } catch (e) {
      // Handle errors
      print('Error fetching best service providers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    String searchText=  translation(context)!.searchPageHOSearchBarLabel;

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color(0xFFF9FAFB), //const Color(0xFFF9FAFB),
        appBar: AppBar(
          leading: const Icon(
            Icons.search,
            color: Colors.white,
            size: 27,
          ),
          title: Text(
            translation(context)!.searchPageHOMainTitle,
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: MediaQuery.of(context).size.width > 930
                      ?
                  EdgeInsets.only(top: 12, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                      :
                  translation(context)!.localeName == 'ar'
                  ? EdgeInsets.only(top: 12, right: 12)
                  : EdgeInsets.only(top: 12, left: 12) ,
                  child: Text(
                    translation(context)!.searchPageHOWelcomeMsg,
                    style: TextStyle(
                      color: Color(0xFF022D6B),
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width > 930
                          ? 35
                          : 25,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: MediaQuery.of(context).size.width > 930
                          ?
                      EdgeInsets.only(top: 16, bottom: 10 , left: MediaQuery.of(context).size.width/3.5)
                          :
                      translation(context)!.localeName == 'ar'
                      ?
                      const EdgeInsets.only(top: 12, bottom: 8, right: 12)
                      :
                      const EdgeInsets.only(top: 12, bottom: 8, left: 12),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width > 930
                            ? MediaQuery.of(context).size.width/2.7
                            : 344,
                        child: GestureDetector(
                          key: searchKey,
                          onTap: () async {
                            List<String> suggestionNames = await HomeOwnerSearchAPI.getSuggestionNames();
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                suggestionNames: suggestionNames,
                                onSearchResults: (results, query) {
                                  Future.microtask(() {
                                    setState(() {
                                      serviceProviders = results;
                                      searchText = query; // Update the search bar text
                                    });
                                  });
                                },
                                initialQuery:'', // Pass the initial search query
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // add the decoration and add a new widget for the search no time to sleep
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: const Color(0xFF022D6B),
                                  width: 1,
                                )),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Icon(
                                    Icons.search_outlined,
                                    size: 25,
                                    color: Color(0xFF022D6B),
                                  ),
                                ),
                                Text(
                                  searchText,
                                  style: TextStyle(
                                    color: Color(0xFF022D6B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 10),
                      child: IconButton(
                        key: filterKey,
                        onPressed: () async {
                          List<String>? UpdatedData = await filterSearch();
                          setState(() {
                            if (UpdatedData != null) {
                              filterRating = int.parse(UpdatedData![0]);
                              filterMinWage = int.parse(UpdatedData![1]);
                              filterMaxWage = int.parse(UpdatedData![2]);
                              filterSPLocation = UpdatedData![3];
                              _filterServiceProviders();

                              // print('${filterRating} : ${filterMinWage} : ${filterMaxWage} : ${filterSPLocation} : ${activeCategory}') ;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.filter_alt,
                          size: 30,
                          color: Color(0xFF022D6B),
                        ),
                      ),
                    ),
                  ],
                ),
                widget.askForRequest    // this means if the ask for request was false then user has enter this page from the navbar and so we show him the services. BUT if its true then user won't need the service
                    ? SizedBox(height: 0,)
                    : Padding(
                  padding: MediaQuery.of(context).size.width > 930
                      ?
                  EdgeInsets.only(top: 12, bottom: 10 , right: 12 , left: 16)
                      :
                  translation(context)!.localeName == 'ar'
                  ?
                  const EdgeInsets.only(top: 12 , bottom: 10 , right: 12 , left: 15)
                  :
                  const EdgeInsets.only(top: 12, bottom: 10, right: 15, left: 12),
                  child: Text(
                    translation(context)!.searchPageHOSearchServices,
                    style: TextStyle(
                      color: Color(0xFF022D6B),
                      fontSize: MediaQuery.of(context).size.width > 930
                          ? 28
                          : 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                widget.askForRequest
                    ? SizedBox(height: 0,)
                    : SizedBox(
                  height: MediaQuery.of(context).size.width > 930
                      ? MediaQuery.of(context).size.width / 30
                      : 55,

                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 10, right: 15, left: 15),
                    child: GestureDetector(
                      key: servicesKey,
                      onTap: () {
                        selectedCategory(categoryList[0]["serviceName"]);
                      },
                      child: CategoriesHo(
                        categoryList: categoryList,
                        selectedCategory: selectedCategory,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: MediaQuery.of(context).size.width > 930
                          ?
                      EdgeInsets.only(top: 12, bottom: 10 , right: 12 , left: 16)
                          :
                      translation(context)!.localeName == 'ar'
                          ?
                      const EdgeInsets.only(top: 12 , bottom: 10 , right: 12 , left: 15)
                          :
                      const EdgeInsets.only(top: 12, bottom: 10, right: 15, left: 12),
                      child: Text(
                        translation(context)!.searchPageHODiscover,
                        style: TextStyle(
                          color: Color(0xFF022D6B),
                          fontSize: MediaQuery.of(context).size.width > 930
                              ? 28
                              : 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => super.widget),
                        );

                      },
                      child: Container(
                        padding: translation(context)!.localeName == 'ar'
                        ? const EdgeInsets.only(top: 5 , left: 12, )
                        : const EdgeInsets.only(top: 5 , right: 12, ),
                        child: Icon(
                          Icons.refresh,
                          size: MediaQuery.of(context).size.width > 930
                              ? 30
                              : 25,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
                  ],
                ),
                SPCard(key: discoverKey ,topServiceProviders: serviceProviders, askForRequest: widget.askForRequest, taskID: taskID),
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
