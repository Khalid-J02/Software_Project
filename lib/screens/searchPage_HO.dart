import 'package:buildnex/Widgets/serviceProvideCard_HO.dart';
import 'package:flutter/material.dart';

import '../Widgets/Categories_HO.dart';
import '../Widgets/CustomSearchDelegate.dart';
import '../Widgets/filterSearch_HO.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _searchController = TextEditingController();
  String activeCategory = '' ;

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
      "serviceName": "plumbing Technician",
      "Icon": Icons.plumbing,
    },
    {
      "serviceName": "Electrical Technician",
      "Icon": Icons.electric_bolt_outlined,
    },
    {
      "serviceName": "Insulation & HVAC Contractors",
      "Icon": Icons.hvac,
    },
    {
      "serviceName": "Plasterer",
      "Icon": Icons.format_paint_outlined,
    },
    {
      "serviceName": "Carpenter",
      "Icon": Icons.carpenter,
    },
    {
      "serviceName": "Tile Contractor",
      "Icon": Icons.person_outlined,
    },
    {
      "serviceName": "Painter",
      "Icon": Icons.format_paint_sharp,
    },
    {
      "serviceName": "Window Installer",
      "Icon": Icons.window_rounded,
    },
  ];

  List<Map<String, dynamic>> jsonList = [
    {
      "image": "images/Testing/Tokyo.jpg",
      "Name": "Tokyo",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 2.8
    },
    {
      "image": "images/Testing/tarabzon2.jpg",
      "Name": "tarabzon2",
      "service" : "Surveyor",
      "price": 35.0,
      "rating" : 4.8
    },
    {
      "image": "images/Testing/Salalah2.jpg",
      "Name": "Salalah2",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 3.5
    },
    {
      "image": "images/Testing/Iceland2.jpg",
      "Name": "Iceland2",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 2.1
    },
    {
      "image": "images/Testing/Dubai2.jpg",
      "Name": "Dubai2",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 1.9
    },
    {
      "image": "images/Testing/Bali2.jpg",
      "Name": "Bali2",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 3.2
    },
    {
      "image": "images/Testing/Tokyo2.jpg",
      "Name": "Tokyo",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 4.1
    },
    {
      "image": "images/Testing/Salalah.jpg",
      "Name": "Salalah",
      "service" : "Surveyor",
      "price": 25.0,
      "rating" : 5.0
    },
  ];


  void selectedCategory(String selectedCategory) {
    setState(() {
      activeCategory = selectedCategory ;
    });
    // print('${activeCategory}') ;
  }

  int filterRating = 1 ;
  int filterMinWage = 10 ;
  int filterMaxWage = 400 ;
  String filterSPLocation = "" ;

  Future <List<String>?> filterSearch()=> showDialog <List<String>>(
      context: context,
      builder: (BuildContext context){
        return FilterSearch(activeCategory: activeCategory, filterRating: filterRating, filterSPLocation: filterSPLocation, filterMinWage: filterMinWage, filterMaxWage: filterMaxWage,);
      }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),//const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: const Icon(Icons.house_outlined , color: Color(0xFFF3D69B), size: 27,),
        title: const Text(
          'Home Page',
          style: TextStyle(
              color: Color(0xFFF3D69B)
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/Profile Icon.png'), // add gesturewidget on tap function
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xFF122247),//Colors.white,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 12, left: 12),
                child: Text(
                  "Welcome Back !",
                  style: TextStyle(
                    color: Color(0xFF022D6B),
                    fontWeight: FontWeight.w500,
                    fontSize: 25
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 8, left: 12),
                    child: SizedBox(
                      height: 50,
                      width: 344,
                      child: GestureDetector(
                        onTap: (){
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(),
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
                            )
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                      Icons.search_outlined ,
                                      size: 25,
                                      color: Color(0xFF022D6B),
                                    ),
                              ),
                              Text(
                                "Search for Service Providers",
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
                      onPressed: () async {
                        List<String>? UpdatedData = await filterSearch();
                        setState(() {
                          if(UpdatedData != null){
                            filterRating = int.parse(UpdatedData![0]);
                            filterMinWage = int.parse(UpdatedData![1]);
                            filterMaxWage = int.parse(UpdatedData![2]);
                            filterSPLocation = UpdatedData![3];
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
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 10, right: 15 , left: 12),
                child: Text(
                  "Services",
                  style: TextStyle(
                    color: Color(0xFF022D6B),
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10, right: 15 , left: 15),
                  child: GestureDetector(
                    onTap: (){
                      /*
                      here we should check which category is presses to send it to the api and
                      get the data based on it.
                       */
                    },
                    child: CategoriesHo(categoryList: categoryList, selectedCategory: selectedCategory,),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 10, right: 15 , left: 12),
                child: Text(
                  "Discover",
                  style: TextStyle(
                    color: Color(0xFF022D6B),
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Flexible(
                child: SPCard(topServiceProviders: jsonList,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
