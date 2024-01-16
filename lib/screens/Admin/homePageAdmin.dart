import 'package:buildnex/screens/Admin/Widgets/ProjectStats/projectProgress.dart';
import 'package:buildnex/screens/Admin/Widgets/ProjectStats/projectStatus.dart';
import 'package:buildnex/screens/Admin/Widgets/ProjectStats/projectsCity.dart';
import 'package:buildnex/screens/Admin/Widgets/TasksStats/tasksStatus.dart';
import 'package:buildnex/screens/Admin/Widgets/UsersStats/homeOwnersCity.dart';
import 'package:buildnex/screens/Admin/Widgets/UsersStats/serviceProviderCity.dart';
import 'package:buildnex/screens/Admin/Widgets/UsersStats/spToRating.dart';
import 'package:buildnex/screens/Admin/Widgets/UsersStats/tasksToService.dart';
import 'package:buildnex/screens/Admin/Widgets/statsCategories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {

  String activeCategory = '';
  String _dropDownValueProjectStatus = 'General';
  String _dropDownValueSPRating = 'General';
  String _dropDownValueTaskStatus = 'General';
  List chartDataprojectStatus = [] ;
  List chartDataSPRating = [] ;
  List chartDataTaskStatus = [] ;

  final List<Map<String, dynamic>> categoryList = [
    {
      "serviceName": "Projects",
      "Icon": Icons.analytics,
      'backgroundColor': Colors.blueGrey[300],
      'IconColor' : Colors.blueGrey[700]
    },
    {
      "serviceName": "Users",
      "Icon": Icons.person,
      'backgroundColor': Colors.orangeAccent,
      'IconColor' : Colors.deepOrange
    },
    {
      "serviceName": "Tasks",
      "Icon": Icons.list_alt_outlined,
      'backgroundColor': Colors.red[300],
      'IconColor' : Colors.red[600],
    },
  ];

  void selectedCategory(String selectedCategory) {
    setState(() {
      activeCategory = selectedCategory;
    });
    if (activeCategory.isNotEmpty)
    {
      // _getServiceProvidersByServiceType(activeCategory);
    }
    else
    {
      // _getBestServiceProviders();

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Home',
            style: TextStyle(
                color: Color(0xFF122247),
                fontSize: 20
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,//Colors.white,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 10, right: 15, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory(categoryList[0]["serviceName"]);
                    },
                    child: StatsCategories(
                      categoryList: categoryList,
                      selectedCategory: selectedCategory,
                    ),
                  ),
                ),
              ),
              activeCategory.isEmpty
                ?
                  Center(
                    child: Text(
                     "Please choose one of the Categories..",
                     style: TextStyle(
                       color: Colors.grey[800],
                       fontWeight: FontWeight.bold,
                       fontSize: 20
                     ),
                    ),
                  )
                :
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0 , horizontal: 10),
                    child: Text(
                      activeCategory,
                      style: const TextStyle(
                        color: Color(0xFF022D6B),
                        fontWeight: FontWeight.w500,
                        fontSize: 26
                      ),
                    ),
                  ),
              // here for the project screen
              activeCategory == 'Projects'
                  ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Project / City Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ProjectsCityDist(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Projects Progress Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ProjectsProgressDist(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            "Projects Status Dist. :",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF022D6B),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Color(0xFFF3D69B)),
                          ),
                          child: DropdownButton<String>(
                            value: _dropDownValueProjectStatus,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropDownValueProjectStatus = newValue!;
                                if(_dropDownValueProjectStatus == 'General'){
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueProjectStatus == 'Nablus'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [22 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [18 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [6 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueProjectStatus == 'Ramallah'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [34 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [60 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [17 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueProjectStatus == 'Qalqilya'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [22 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [18 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [6 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueProjectStatus == 'Jenin'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [13 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [6 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [33, 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueProjectStatus == 'Jericho'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataprojectStatus = [
                                      [22 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [18 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [6 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                              });
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, MediaQuery.of(context).size.width / 3, 0)
                                      :
                                  const EdgeInsets.fromLTRB(12, 0, 55, 0),
                                  child: const Text('General'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Nablus',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Nablus'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Ramallah',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Ramallah'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Tulkarm',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Tulkarm'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Qalqilya',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Qalqilya'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jenin',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jenin'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jericho',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jericho'),
                                ),
                              )
                            ],
                            dropdownColor: const Color(0xFF2F4771),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProjectsStatusDist(chartData: chartDataprojectStatus,)
                ],
              )
                  :
              Container(),
              // here for the users
              activeCategory == 'Users'
                  ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "HomeOwner / City Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  HomeOwnersCityDist(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Service Provider / City Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ServiceProvidersCityDist(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      " Finished Tasks / Service Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  TasksToServiceDist(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            "Service Provider Dist. :",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF022D6B),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Color(0xFFF3D69B)),
                          ),
                          child: DropdownButton<String>(
                            value: _dropDownValueSPRating,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropDownValueSPRating = newValue!;
                                if(_dropDownValueSPRating == 'General'){
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueSPRating == 'Nablus'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueSPRating == 'Ramallah'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueSPRating == 'Qalqilya'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueSPRating == 'Jenin'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueSPRating == 'Jericho'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataSPRating = [
                                      [40 , '1' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , '2' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , '3' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '4' , const Color.fromRGBO(123, 201, 82, 1)],
                                      [20 , '5' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                              });
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, MediaQuery.of(context).size.width / 3, 0)
                                      :
                                  const EdgeInsets.fromLTRB(12, 0, 55, 0),
                                  child: const Text('General'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Nablus',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Nablus'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Ramallah',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Ramallah'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Tulkarm',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Tulkarm'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Qalqilya',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Qalqilya'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jenin',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jenin'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jericho',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jericho'),
                                ),
                              )
                            ],
                            dropdownColor: const Color(0xFF2F4771),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ServiceProviderRatingDist(chartData: chartDataSPRating,),
                ],
              )
                  :
              Container(),
              // here for the tasks
              activeCategory == 'Tasks'
                  ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      " Finished Tasks / Service Distribution :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  TasksToServiceDist(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            "Tasks Status / City :",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF022D6B),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 150,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F4771),
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: Color(0xFFF3D69B)),
                          ),
                          child: DropdownButton<String>(
                            value: _dropDownValueTaskStatus,
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _dropDownValueTaskStatus = newValue!;
                                if(_dropDownValueTaskStatus == 'General'){
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueTaskStatus == 'Nablus'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueTaskStatus == 'Ramallah'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueTaskStatus == 'Qalqilya'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueTaskStatus == 'Jenin'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                                else if(_dropDownValueTaskStatus == 'Jericho'){
                                  // هون الاحسن تعملي زي فنكشن ببعثله انا المدينة و هو برجع الشي مباشرة بس انا هون عشان بتست ستاتيك داتا عملتها هيك
                                  setState(() {
                                    chartDataTaskStatus = [
                                      [40 , 'Not Started' , const Color.fromRGBO(255, 80, 57, 1)],
                                      [12 , 'In Progress' , const Color.fromRGBO(255, 171, 67, 1)],
                                      [20 , 'Finished' , const Color.fromRGBO(123, 201, 82, 1)],
                                    ];
                                  });
                                }
                              });
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, MediaQuery.of(context).size.width / 3, 0)
                                      :
                                  const EdgeInsets.fromLTRB(12, 0, 55, 0),
                                  child: const Text('General'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Nablus',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Nablus'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Ramallah',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Ramallah'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Tulkarm',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Tulkarm'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Qalqilya',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Qalqilya'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jenin',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jenin'),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Jericho',
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  child: const Text('Jericho'),
                                ),
                              )
                            ],
                            dropdownColor: const Color(0xFF2F4771),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TasksStatusDist(chartData: chartDataTaskStatus,),
                ],
              )
                  :
              Container(),
            ],
          )
        ),
      )
    );
  }
}
