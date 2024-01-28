import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:buildnex/Widgets/ratingReviewBar.dart';
import 'package:buildnex/Widgets/reviewTab.dart';
import 'package:buildnex/Widgets/sp_AssetsItem.dart';
import 'package:buildnex/Widgets/sp_CatalogItem.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Widgets/customAlertDialog.dart';


// void main() {
//   runApp(GetMaterialApp(home: SPProfilePage(askForRequest: true,),));
// }

class SPProfilePage extends StatefulWidget {
  final bool askForRequest ;
  String serviceProviderName ;
  String serviceProviderType ;
  String serviceProviderImage ;
  double serviceProviderRating ;
  Map<String, dynamic> bestServiceProviders ;
  List<Map<String, dynamic>> providerCatalog ;
  List<Map<String, dynamic>> providerWorkExp ;
  List<Map<String, dynamic>> providerReviews ;

  SPProfilePage(
      {
        super.key ,
        required this.askForRequest,
        required this.serviceProviderName,
        required this.serviceProviderType,
        required this.serviceProviderImage,
        required this.serviceProviderRating,
        required this.bestServiceProviders,
        required this.providerCatalog,
        required this.providerWorkExp,
        required this.providerReviews
      }
  );

  @override
  State<SPProfilePage> createState() => _SPProfilePageState();
}

class _SPProfilePageState extends State<SPProfilePage> with ChangeNotifier{


  int? activeIndex = 0 ;
  int? providerCompletedTasks ;
  late String provider5Rating ;
  late String provider4Rating ;
  late String provider3Rating ;
  late String provider2Rating ;
  late String provider1Rating ;
  int? providerReviewsCount ;
  late String taskId ;
  late String sPID ;

  late List<Map<String, dynamic>> jsonList ;
  late List<Map<String, dynamic>> workList ;
  late List<Map<String, dynamic>> reviewList ;
  late Map<String, dynamic> args ;

  @override
  void initState() {
    // TODO: implement initState
    // _getProviderInfo() ;
    super.initState();
    args = Get.arguments ;
    setState(() {
      providerCompletedTasks = widget.bestServiceProviders['CompletedTasks'] ;
      providerReviewsCount = widget.bestServiceProviders['ReviewsCount'] ;
      provider5Rating = widget.bestServiceProviders['PercentageRating5'] ;
      provider4Rating = widget.bestServiceProviders['PercentageRating4'] ;
      provider3Rating = widget.bestServiceProviders['PercentageRating3'] ;
      provider2Rating = widget.bestServiceProviders['PercentageRating2'] ;
      provider1Rating = widget.bestServiceProviders['PercentageRating1'] ;
      jsonList = widget.providerCatalog ;
      workList = widget.providerWorkExp ;
      reviewList = widget.providerReviews ;
      taskId = args['taskId'] ;
      sPID = args['serviceProviderID'] ;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> sendRequest(String requestDate)async {
    final String data = await ServiceProviderDataAPI.sendRequestForServiceProvider(sPID, taskId.toString(), requestDate) ;
    if(data == 'Request for the specified task already sent') {
      showDialog(
        context: context, // Ensure context is available
        builder: (context) => AlertDialog(
          title: const Text('Request Already Sent'),
          content: const Text('An error occurred: A request for this specific task has already been submitted by you. Please await a response from the service provider to whom the request was sent.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    else if(data == 'Request submitted successfully'){
      showDialog(
        context: context, // Ensure context is available
        builder: (context) => AlertDialog(
          title: const Text('Request is Sent Successfully'),
          content: const Text('You Have Sent a Request To This Service Provider Successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if(translation(context)!.localeName == 'ar'){
      if(widget.serviceProviderType == 'Surveyor'){
        setState(() {
          widget.serviceProviderType = 'مساح' ;
        });
      }
      if(widget.serviceProviderType == 'Engineering Office'){
        setState(() {
          widget.serviceProviderType = 'مكتب هندسي' ;
        });
      }
      if(widget.serviceProviderType == 'Constructor'){
        setState(() {
          widget.serviceProviderType = 'مقاول' ;
        });
      }
      if(widget.serviceProviderType == 'Plumbing Technician'){
        setState(() {
          widget.serviceProviderType = 'فني سباكة' ;
        });
      }
      if(widget.serviceProviderType == 'Electrical Technician'){
        setState(() {
          widget.serviceProviderType = 'فني كهرباء' ;
        });
      }
      if(widget.serviceProviderType == 'Insulation Technician'){
        setState(() {
          widget.serviceProviderType = 'فني عزل' ;
        });
      }
      if(widget.serviceProviderType == 'Carpenter'){
        setState(() {
          widget.serviceProviderType = 'نجار' ;
        });
      }
      if(widget.serviceProviderType == 'Plasterer'){
        setState(() {
          widget.serviceProviderType = 'عامل تجصيص' ;
        });
      }
      if(widget.serviceProviderType == 'Tile Contractor'){
        setState(() {
          widget.serviceProviderType = 'مقاول بلاط' ;
        });
      }
      if(widget.serviceProviderType == 'Window Installer'){
        setState(() {
          widget.serviceProviderType = 'عامل تركيب نوافذ' ;
        });
      }
      if(widget.serviceProviderType == 'Painter'){
        setState(() {
          widget.serviceProviderType = 'فني طلاء' ;
        });
      }
    }

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            //projectName,
            translation(context)!.homeOwnerProjectNavAppBarTitle,
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: MediaQuery.of(context).size.width > 930
                          ?
                      EdgeInsets.only(left: 90)
                          :
                      EdgeInsets.zero,
                      padding: MediaQuery.of(context).size.width > 930
                        ?
                      EdgeInsets.only(top: 20 ,left: 20, bottom: 30)
                        :
                      EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      height: MediaQuery.of(context).size.width > 930
                          ? MediaQuery.of(context).size.width / 5
                          : 200,
                      width: MediaQuery.of(context).size.width > 930
                          ? MediaQuery.of(context).size.width / 5
                          : 200,
                      child: Card(
                        shape:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.transparent, width: 1)
                        ),
                        shadowColor: const Color(0xff26364b),

                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)) ,
                          child: Image(
                            image: NetworkImage(widget.serviceProviderImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: MediaQuery.of(context).size.width > 930
                            ? const EdgeInsets.symmetric(horizontal: 60 , vertical: 20)
                            : const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                widget.serviceProviderName,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width > 930
                                      ? 50
                                      : 30,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                widget.serviceProviderType,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width > 930
                                      ? 25
                                      : 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                translation(context)!.sPProfilePageHOCompletedTasks + providerCompletedTasks.toString() ,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width > 930
                                      ? 25
                                      : 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            ),
                            SizedBox(height: 10,),
                            widget.askForRequest
                            ? GestureDetector(
                                onTap: () async {
                                  final String data = await ServiceProviderDataAPI.checkRequestForServiceProvider(sPID, taskId.toString()) ;
                                  if(data == 'Request for the specified task already sent') {

                                      showDialog(
                                        context: context, // Ensure context is available
                                        builder: (context) => AlertDialog(
                                          title: const Text('Request Already Sent'),
                                          content: const Text('An error occurred: A request for this specific task has already been submitted by you. Please await a response from the service provider to whom the request was sent.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );

                                  }
                                  else if(data == 'You can send a Request') {
                                    String? pickedDate = await CustomAlertDialog.showExpectedStartDatefortheTask(context);
                                    if (pickedDate != null) {
                                    } else {
                                      // do nothing
                                    }
                                    await sendRequest(pickedDate!);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width > 930
                                      ? 170
                                      : 155,
                                  height: MediaQuery.of(context).size.width > 930
                                      ? 35
                                      : 30,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFF122247),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Request Assign",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width > 930
                                            ? 18
                                            : 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            :
                              SizedBox(width: 2,),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: translation(context)!.localeName == 'ar'
                        ? const EdgeInsets.only(right: 20.0 )
                        : const EdgeInsets.only(left: 20.0 ),
                        child: MediaQuery.of(context).size.width > 930
                            ?
                        Center(
                          child: Text(
                            widget.serviceProviderRating.toString(),
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                            :
                        Text(
                          widget.serviceProviderRating.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          RatingReview(text: '5', value: double.parse(provider5Rating) ,),
                          RatingReview(text: '4', value: double.parse(provider4Rating),),
                          RatingReview(text: '3', value: double.parse(provider3Rating),),
                          RatingReview(text: '2', value: double.parse(provider2Rating),),
                          RatingReview(text: '1', value: double.parse(provider1Rating),),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: MediaQuery.of(context).size.width > 930
                      ?
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 7 - 30)
                      :
                  const EdgeInsets.symmetric(horizontal: 12.0),
                  child: RatingBarIndicator(
                    rating: widget.serviceProviderRating,
                    itemSize: MediaQuery.of(context).size.width > 930
                        ? 26
                        : 18,
                    unratedColor: Colors.grey,
                    itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFF122247),),
                  ),
                ),
                Padding(
                  padding: MediaQuery.of(context).size.width > 930
                      ?
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 7 - 30)
                      :
                  const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    providerReviewsCount.toString() + translation(context)!.sPProfilePageHOReviews,
                    // "${providerReviewsCount} Reviews" ,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 930
                          ? 22
                          : 16,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: ToggleSwitch(
                      minWidth: MediaQuery.of(context).size.width > 930
                          ? 160
                          : 120,
                      minHeight: MediaQuery.of(context).size.width > 930
                          ? 55
                          : 45.0,
                      cornerRadius: 30.0,
                      fontSize: MediaQuery.of(context).size.width > 930
                          ? 22
                          : 16.0,
                      initialLabelIndex: activeIndex,
                      // borderColor: [Colors.grey[400]!] ,
                      activeBgColor: [Color(0xFF1C437A)] ,
                      inactiveBgColor: Colors.grey[200],
                      labels: [translation(context)!.sPProfilePageHOBarCatalog, translation(context)!.sPProfilePageHOBarWork, translation(context)!.sPProfilePageHOBarReviews],
                      icons: [Icons.folder_copy , Icons.work , Icons.reviews],
                      onToggle: (index) {
                        setState(() {
                          activeIndex = index ;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                if(activeIndex == 0)
                  if(jsonList.length != 0)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width > 930
                          ? ((MediaQuery.of(context).size.width / 5) - (0)) * (jsonList.length / 5).ceil() * (1/1)
                          : ((MediaQuery.of(context).size.width / 2) - (0)) * (jsonList.length / 2).ceil() * (1/1),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: jsonList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width > 930
                              ? 5
                              : 2,
                        ),
                        itemBuilder: (context , index){
                          var ItemObject = jsonList[index];
                          return GestureDetector(
                              onTap: () async {
                                final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(ItemObject["CatalogID"].toString());
                                Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
                              },
                              child: ServiceProvideCatalogItem(catalogItemImageURL: ItemObject["ItemImage"], catalogItemImageName: ItemObject["ItemName"], catalogItemPrice: ItemObject["ItemPrice"].toDouble(), catalogItemRating: ItemObject["ItemRating"].toDouble(),)

                          );
                        },
                      ),
                    ),
                if(activeIndex == 0 && jsonList.length == 0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width > 930
                        ? ((MediaQuery.of(context).size.width / 5) - (0)) * (4 / 5).ceil() * (1/1)
                        : ((MediaQuery.of(context).size.width / 2) - (0)) * (4 / 2).ceil() * (1/1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(translation(context)!.sPProfilePageHOBarNoItemsFound,
                            style: TextStyle(
                                color: Colors.grey[600] ,
                                fontSize: MediaQuery.of(context).size.width > 930
                                    ? 22
                                    : 18 ,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                if(activeIndex == 1 && workList.length != 0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width > 930
                        ? ((MediaQuery.of(context).size.width / 5) - (0)) * (workList.length / 5).ceil() * (1/1)
                        : ((MediaQuery.of(context).size.width / 2) - (0)) * (workList.length / 2).ceil() * (1/1),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: workList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 930
                            ? 5
                            : 2,
                      ),
                      itemBuilder: (context , index){
                        var ItemObject = workList[index];
                        return ServiceProvideAssetsItem(
                            catalogItemImageURL: ItemObject["WorkImage"],
                            catalogItemImageName: ItemObject["WorkName"]
                        );
                      },
                    ),
                  ),
                if(activeIndex == 1 && workList.length == 0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width > 930
                        ? ((MediaQuery.of(context).size.width / 5) - (0)) * (4 / 5).ceil() * (1/1)
                        : ((MediaQuery.of(context).size.width / 2) - (0)) * (4 / 2).ceil() * (1/1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(translation(context)!.sPProfilePageHOBarNoItemsFound,
                              style: TextStyle(
                                  color: Colors.grey[600] ,
                                  fontSize:MediaQuery.of(context).size.width > 930
                                      ? 22
                                      : 18 ,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                if(activeIndex == 2 && reviewList.length != 0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: ((MediaQuery.of(context).size.width / 1) - (0)) * (reviewList.length / 1).ceil() * (1/1),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reviewList.length,
                      itemBuilder: (context , index){
                        var ItemObject = reviewList[index];
                        return SPReviews(
                          imageURL: ItemObject["HomeOwnerPicture"],
                          name: ItemObject["HomeOwnerName"],
                          rating: ItemObject["Rating"].toDouble(),
                          date: ItemObject["ReviewDate"],
                          reviewText: ItemObject["ReviewContent"],
                        );
                      },
                    ),
                  ),
                if(activeIndex == 2 && workList.length == 0)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width > 930
                        ? ((MediaQuery.of(context).size.width / 5) - (0)) * (4 / 5).ceil() * (1/1)
                        : ((MediaQuery.of(context).size.width / 2) - (0)) * (4 / 2).ceil() * (1/1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(translation(context)!.sPProfilePageHOBarNoReviewsFound,
                              style: TextStyle(
                                  color: Colors.grey[600] ,
                                  fontSize: MediaQuery.of(context).size.width > 930
                                      ? 22
                                      : 18 ,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

