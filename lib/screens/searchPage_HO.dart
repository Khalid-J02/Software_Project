import 'package:buildnex/Widgets/serviceProvideCard_HO.dart';
import 'package:flutter/material.dart';
import '../Widgets/Categories_HO.dart';
import '../Widgets/CustomSearchDelegate.dart';
import '../Widgets/customAlertDialog.dart';
import '../Widgets/filterSearch_HO.dart';

import '../APIRequests/homeOwnerSearchAPI.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Map<String, dynamic>> serviceProviders =
      []; // getBestFourServiceProviders

  final _searchController = TextEditingController();
  String activeCategory = '';
  String searchText=  "Search for Service Providers";

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



  @override
  void initState() {
    super.initState();
    // Call the API to get the best service providers
    _getBestServiceProviders();
  }


  Future<void> _getServiceProvidersByServiceType(String serviceType) async {
    try {
      final List<Map<String, dynamic>> providers =
      await HomeOwnerSearchAPI.getServiceProvidersByServiceType(
          serviceType);

      setState(() {
        serviceProviders = providers;
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
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB), //const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: const Icon(
          Icons.house_outlined,
          color: Color(0xFFF3D69B),
          size: 27,
        ),
        title: const Text(
          'Home Page',
          style: TextStyle(color: Color(0xFFF3D69B)),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'images/Profile Icon.png'), // add gesturewidget on tap function
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
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
                      fontSize: 25),
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

              const Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 10, right: 15, left: 12),
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
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 10, right: 15, left: 15),
                  child: GestureDetector(
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
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 12, bottom: 10, right: 15, left: 12),
                    child: Text(
                      "Discover",
                      style: TextStyle(
                        color: Color(0xFF022D6B),
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      /*
                        here we should do the refresh
                       */
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => super.widget),
                      );

                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 5 , right: 12, ),
                      child: const Icon(
                        Icons.refresh,
                        size: 25,
                        color: Color(0xFF122247),
                      ),
                    ),
                  ),
                ],
              ),

              Flexible(
                child: SPCard(topServiceProviders: serviceProviders),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
