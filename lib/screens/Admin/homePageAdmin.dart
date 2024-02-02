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

import '../../APIRequests/adminSystem.dart';
import '../../Widgets/customAlertDialog.dart';

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

  //////////////////////////////////
  List ProjectCountByCity = [];
  List ProjectCountByCompletion = [];
  List HomeownerCountByCity = [];
  List ServiceProviderCountByCity = [];
  List TaskCountByServiceType = [];

  final List<Map<String, dynamic>> categoryList = [
    {

      "serviceName": "Constructions",
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
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    try {
      var projectCountByCity = await AdminAPI.getProjectCountByCity();
      var projectCountByCompletion = await AdminAPI.getProjectCountByCompletion();
      var homeownerCountByCity =  await AdminAPI.getHomeownerCountByCity();
      var serviceProviderCountByCity =  await AdminAPI.getServiceProviderCountByCity();
      var taskCountByServiceType = await AdminAPI.getTaskCountByServiceType(); // Make sure this matches your API method

      setState(() {
        ProjectCountByCity = projectCountByCity;
        ProjectCountByCompletion = projectCountByCompletion;
        HomeownerCountByCity = homeownerCountByCity;
        ServiceProviderCountByCity = serviceProviderCountByCity;
        TaskCountByServiceType = taskCountByServiceType;

      });
    } catch (e) {
      // Handle exceptions
      print("Error fetching data: $e");
    }
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Not Started':
        return const Color.fromRGBO(255, 80, 57, 1);
      case 'In Progress':
        return const Color.fromRGBO(255, 171, 67, 1);
      case 'Completed':
        return const Color.fromRGBO(123, 201, 82, 1);
      default:
        return Colors.grey;
    }
  }

  void fetchSPRatingData(String city) async {
    try {
      var response = await AdminAPI.getServiceProviderCountByRating(city);
      List<dynamic> newChartData = [];
      response.forEach((key, value) {
        int rating = int.parse(key.split('_')[1]);
        String label = '★' * rating;
        Color color;
        switch (rating) {
          case 1:
            color = const Color.fromRGBO(255, 80, 57, 1);
            break;
          case 2:
            color = const Color.fromRGBO(255, 171, 67, 1);
            break;
          case 3:
            color = const Color.fromRGBO(123, 201, 82, 1);
            break;
          case 4:
            color = const Color.fromRGBO(123, 201, 255, 1);
            break;
          case 5:
            color = const Color.fromRGBO(0, 117, 194, 1);
            break;
          default:
            color = Colors.grey;
        }
        newChartData.add([value, label, color]);
      });

      setState(() {
        chartDataSPRating = newChartData;
      });
    } catch (e) {
      // Handle exceptions
      print("Error fetching data: $e");
    }
  }

  fetchTaskStatusData(String city) async {
    try {
      var taskStatusData = await AdminAPI.getTaskCountByStatusForCity(city);
      setState(() {
        chartDataTaskStatus = taskStatusData.map((data) {
          return [
            data['taskCount'],
            data['TaskStatus'],
            getTaskStatusColor(data['TaskStatus'])
          ];
        }).toList();
      });
    } catch (e) {
      print('Error fetching task status data: $e');
    }
  }

  Color getTaskStatusColor(String status) {
    Map<String, Color> statusColorMap = {
      'Not Started': const Color.fromRGBO(255, 80, 57, 1),
      'In Progress': const Color.fromRGBO(255, 171, 67, 1),
      'Completed': const  Color.fromRGBO(123, 201, 82, 1),
    };
    return statusColorMap[status] ?? Colors.grey;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.home, color: Color(0xFFF3D69B),),
          title: const Text(
            'Home',
            style: TextStyle(
                color: Color(0xFFF3D69B)
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout , color: Color(0xFFF3D69B) , size: 24,),
              onPressed: () async {
                bool? shouldLogout = await CustomAlertDialog.showLogoutConfirmationDialog(context);
                if (shouldLogout == true) {
                  Get.offAllNamed('/');

                }
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Color(0xFF122247),//Colors.white,
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
                      top: 15, bottom: 15, right: 50, left: 65),
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
              activeCategory == 'Constructions'
                  ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Constructions Per City :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ProjectsCityList(chartData: ProjectCountByCity),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Constructions Completion :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ProjectsProgressList(chartData: ProjectCountByCompletion,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            "Constructions Status :",
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
                            onChanged: (String? newValue) async {
                              setState(() {
                                _dropDownValueProjectStatus = newValue!;
                              });
                              try {
                                var projectStatusData = await AdminAPI.getProjectCountByStatusForCity(_dropDownValueProjectStatus);
                                List<dynamic> formattedData = projectStatusData.entries.map((entry) {
                                  return [entry.value, entry.key, getColorForStatus(entry.key)];
                                }).toList();

                                setState(() {
                                  chartDataprojectStatus = formattedData;
                                });
                              } catch (e) {
                                // Handle exceptions
                                print("Error fetching data: $e");
                              }
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, 55, 0)
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
                  ProjectsStatusList(chartData: chartDataprojectStatus,)
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
                      "Home Owners Per City :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  HomeOwnersCityList(chartData: HomeownerCountByCity),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      "Service Providers Per City :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  ServiceProvidersCityList(chartData: ServiceProviderCountByCity),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            "Service Provider Rating :",
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
                              if (newValue != null) {
                                setState(() {
                                  _dropDownValueSPRating = newValue;
                                });
                                fetchSPRatingData(newValue);
                              }
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, 55, 0)
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
                  ServiceProviderRatingList(chartData: chartDataSPRating,),
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
                      "Completed Tasks Per Service :",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF022D6B),
                      ),
                    ),
                  ),
                  TasksToServiceList(chartData: TaskCountByServiceType,),
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
                              if (newValue != null) {
                                setState(() {
                                  _dropDownValueTaskStatus = newValue;
                                });
                                fetchTaskStatusData(newValue); // Fetch new data for the selected city
                              }
                            },
                            items: [
                              DropdownMenuItem<String>(
                                value: 'General',
                                child: Container(
                                  margin: MediaQuery.of(context).size.width > 930
                                      ?
                                  EdgeInsets.fromLTRB(12, 0, 55, 0)
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
                  TasksStatusList(chartData: chartDataTaskStatus,),
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
