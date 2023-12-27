import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:buildnex/Widgets/ratingReviewBar.dart';
import 'package:buildnex/Widgets/reviewTab.dart';
import 'package:buildnex/Widgets/sp_AssetsItem.dart';
import 'package:buildnex/Widgets/sp_CatalogItem.dart';
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

  late List<Map<String, dynamic>> jsonList ;
  late List<Map<String, dynamic>> workList ;
  late List<Map<String, dynamic>> reviewList ;

  // List<Map<String, dynamic>> reviewList = [
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "Tokyo",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "tarabzon2",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "Salalah2",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "Iceland2",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "Dubai2",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  //   {
  //     "image": "https://picsum.photos/200/300",
  //     "Name": "Bali2",
  //     "rating": 3.2,
  //     "Date" : "13 Dec, 2023",
  //     "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    // _getProviderInfo() ;
    super.initState();
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
    });
    print(reviewList) ;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          //projectName,
          "Back",
          style: TextStyle(color: Color(0xFFF3D69B)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  height: 200,
                  width: 200,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.serviceProviderName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.serviceProviderType,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          "Completed Tasks   ${providerCompletedTasks}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ),
                      SizedBox(height: 10,),
                      widget.askForRequest
                      ? GestureDetector(
                          onTap: () async {
                            /*
                              here we will add the functionality of the request
                            */

                            /*and this is the dialog and how to deal with it
                            String? pickedDate = await CustomAlertDialog.showExpectedStartDatefortheTask(context);
                            if (pickedDate != null) {
                              // The user picked a date and tapped "Submit"
                              print("The picked date is: $pickedDate");
                            } else {
                              // The user cancelled the dialog or dismissed it without submitting
                              print("No date was picked.");
                            }*/


                          },
                          child: Container(
                            width: 155,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF122247),
                            ),
                            child: Center(
                              child: Text(
                                "Request Assign",
                                style: TextStyle(
                                  fontSize: 15,
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0 ),
                    child: Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: RatingBarIndicator(
                rating: widget.serviceProviderRating,
                itemSize: 18,
                unratedColor: Colors.grey,
                itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFF122247),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("${providerReviewsCount} Reviews" , style: TextStyle(fontSize: 16,),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: ToggleSwitch(
                  minWidth: 120,
                  minHeight: 45.0,
                  cornerRadius: 30.0,
                  fontSize: 16.0,
                  initialLabelIndex: activeIndex,
                  // borderColor: [Colors.grey[400]!] ,
                  activeBgColor: [Color(0xFF1C437A)] ,
                  inactiveBgColor: Colors.grey[200],
                  labels: ['Catalog', 'Work Exp.', 'Reviews'],
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
                Expanded(
                  child: GridView.builder(
                    itemCount: jsonList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('There is no items to see here...',
                      style: TextStyle(
                          color: Colors.grey[600] ,
                          fontSize: 18 , fontWeight:
                          FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if(activeIndex == 1 && workList.length != 0)
              Expanded(
                child: GridView.builder(
                  itemCount: workList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('There is no items to see here...',
                        style: TextStyle(
                            color: Colors.grey[600] ,
                            fontSize: 18 , fontWeight:
                        FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if(activeIndex == 2 && reviewList.length != 0)
              Expanded( ////SPReviews(),
                child: ListView.builder(
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('There is no reviews yet...',
                        style: TextStyle(
                            color: Colors.grey[600] ,
                            fontSize: 18 , fontWeight:
                        FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

