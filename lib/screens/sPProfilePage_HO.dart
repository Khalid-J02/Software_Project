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


void main() {
  runApp(GetMaterialApp(home: SPProfilePage(askForRequest: true,),));
}

class SPProfilePage extends StatefulWidget {
  final bool askForRequest ;
  
  const SPProfilePage({super.key , required this.askForRequest});

  @override
  State<SPProfilePage> createState() => _SPProfilePageState();
}

class _SPProfilePageState extends State<SPProfilePage> with ChangeNotifier{


  int? activeIndex = 0 ;
  List<Map<String, dynamic>> jsonList = [
    {
      "image": "images/Testing/Tokyo.jpg",
      "Name": "Tokyo",
      "price": 25.0,
      "rating" : 2.8
    },
    {
      "image": "images/Testing/tarabzon2.jpg",
      "Name": "tarabzon2",
      "price": 35.0,
      "rating" : 4.8
    },
    {
      "image": "images/Testing/Salalah2.jpg",
      "Name": "Salalah2",
      "price": 25.0,
      "rating" : 3.5
    },
    {
      "image": "images/Testing/Iceland2.jpg",
      "Name": "Iceland2",
      "price": 25.0,
      "rating" : 2.1
    },
    {
      "image": "images/Testing/Dubai2.jpg",
      "Name": "Dubai2",
      "price": 25.0,
      "rating" : 1.9
    },
    {
      "image": "images/Testing/Bali2.jpg",
      "Name": "Bali2",
      "price": 25.0,
      "rating" : 3.2
    },
    {
      "image": "images/Testing/Tokyo2.jpg",
      "Name": "Tokyo",
      "price": 25.0,
      "rating" : 4.1
    },
    {
      "image": "images/Testing/Salalah.jpg",
      "Name": "Salalah",
      "price": 25.0,
      "rating" : 5.0
    },
  ];

  List<Map<String, dynamic>> workList = [
    {
      "image": "images/Testing/Tokyo.jpg",
      "Name": "Tokyo",
    },
    {
      "image": "images/Testing/tarabzon2.jpg",
      "Name": "tarabzon2",
    },
    {
      "image": "images/Testing/Salalah2.jpg",
      "Name": "Salalah2",
    },
    {
      "image": "images/Testing/Iceland2.jpg",
      "Name": "Iceland2",
    },
    {
      "image": "images/Testing/Dubai2.jpg",
      "Name": "Dubai2",
    },
    {
      "image": "images/Testing/Bali2.jpg",
      "Name": "Bali2",
    },
    {
      "image": "images/Testing/Tokyo2.jpg",
      "Name": "Tokyo",
    },
    {
      "image": "images/Testing/Salalah.jpg",
      "Name": "Salalah",
    },
  ];

  List<Map<String, dynamic>> reviewList = [
    {
      "image": "https://picsum.photos/200/300",
      "Name": "Tokyo",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
    {
      "image": "https://picsum.photos/200/300",
      "Name": "tarabzon2",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
    {
      "image": "https://picsum.photos/200/300",
      "Name": "Salalah2",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
    {
      "image": "https://picsum.photos/200/300",
      "Name": "Iceland2",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
    {
      "image": "https://picsum.photos/200/300",
      "Name": "Dubai2",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
    {
      "image": "https://picsum.photos/200/300",
      "Name": "Bali2",
      "rating": 3.2,
      "Date" : "13 Dec, 2023",
      "Data" : "This game was a core childhood memory, so when I was trying to find a good offline road trip game and came across Subway Surfers, I couldn't help but buy it. Not only is it fun, there is so much you can do! Daily challenges for endless possibilities. I love, Love, LOVE this game to death. Especially for long car rides."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF3D69B),
        ),
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
                  height: 220,
                  width: 220,
                  child: Card(
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.transparent, width: 1)
                    ),
                    shadowColor: const Color(0xff26364b),

                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)) ,
                      child: Image(
                        image: AssetImage("images/Testing/Tokyo2.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Khalid Jabr",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Electrical service Provider",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Completed Tasks   33",
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
                      "4.7",
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
                      RatingReview(text: '5', value: 0.9,),
                      RatingReview(text: '4', value: 0.6,),
                      RatingReview(text: '3', value: 0.7,),
                      RatingReview(text: '2', value: 0.3,),
                      RatingReview(text: '1', value: 0.1,),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: RatingBarIndicator(
                rating: 4.7,
                itemSize: 18,
                unratedColor: Colors.grey,
                itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFF122247),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("10,888 Reviews" , style: TextStyle(fontSize: 16,),),
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
              Expanded(
                child: GridView.builder(
                  itemCount: jsonList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context , index){
                    var ItemObject = jsonList[index];
                    return GestureDetector(
                        onTap: (){
                          Get.to(SPCatalogItem_HO(itemImage: ItemObject["image"], itemName: ItemObject["Name"],));
                        },
                        child: ServiceProvideCatalogItem(catalogItemImageURL: ItemObject["image"], catalogItemImageName: ItemObject["Name"], catalogItemPrice: ItemObject["price"], catalogItemRating: ItemObject["rating"],)

                    );
                  },
                ),
              ),
            if(activeIndex == 1)
              Expanded(
                child: GridView.builder(
                  itemCount: workList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context , index){
                    var ItemObject = workList[index];
                    return ServiceProvideAssetsItem(catalogItemImageURL: ItemObject["image"], catalogItemImageName: ItemObject["Name"]);
                  },
                ),
              ),
            if(activeIndex == 2)
              Expanded( ////SPReviews(),
                child: ListView.builder(
                  itemCount: reviewList.length,
                  itemBuilder: (context , index){
                    var ItemObject = reviewList[index];
                    return SPReviews(imageURL: ItemObject["image"], name: ItemObject["Name"], rating: ItemObject["rating"], date: ItemObject["Date"], reviewText: ItemObject["Data"],);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

