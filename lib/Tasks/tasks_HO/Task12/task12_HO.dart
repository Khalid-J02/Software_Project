import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/taskWidgets/catalogDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/homeOwnerTasksAPI.dart';


void main() {
  runApp(GetMaterialApp(home: TileInstallHO()));
}

class TileInstallHO extends StatefulWidget {
  const TileInstallHO({super.key});

  @override
  State<TileInstallHO> createState() => _TileInstallHOState();
}

class _TileInstallHOState extends State<TileInstallHO> {

  List<Map<String, dynamic>> userChoices = [];


  Map<String, dynamic> task12Data = {};
  String taskID = '';
  String taskProjectId = '';

  int? bathroomTileCatalogID;
  int? houseTileCatalogID;

  @override
  void initState() {
    super.initState();
    fetchArgumentsAndData();
  }

  Future<void> fetchArgumentsAndData() async {
    try {

      Map<String, dynamic> arguments = Get.arguments;
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      final Map<String, dynamic> data =
      await HomeOwnerTasksAPI.getTask6(taskID);
      final Map<String, dynamic> projectInfoData = await HomeOwnerTasksAPI.getProjectInfoData( int.parse(taskProjectId));

      // here we will send service provider id we got from above function ( await HomeOwnerTasksAPI.getTask6(taskID);)
      // it contains UserID
      // await HomeOwnerTasksAPI.getServiceProviderCatalogItems();

      //here we will send catalog id
      //HomeOwnerTasksAPI.getServiceProviderCatalogItemDetails();

      setState(() {
        task12Data = data;
        bathroomTileCatalogID = projectInfoData['BathroomTile'] != null
            ? int.tryParse(projectInfoData['BathroomTile'])
            : 0;

        houseTileCatalogID = projectInfoData['HouseTile'] != null
            ? int.tryParse(projectInfoData['HouseTile'])
            : 0;


        // if this values are not 0, (not null), they have selected before, so we will display its values from the database
        if(bathroomTileCatalogID != 0) {
        }

        if(houseTileCatalogID != 0) {
        }

      });

    } catch (e) {
      print('Error fetching task12 data: $e');
    }
  }


  Future<void> openCatalog() async {
    Map<String, dynamic>? newProject = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return CatalogDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF3D69B),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
          child: const Text(
            "Task Details",
            style: TextStyle(color: Color(0xFFF3D69B)),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TaskInformation(taskID: task12Data['TaskID']?? 0, taskName: task12Data['TaskName']?? 'Unknown', projectName: task12Data['ProjectName']?? 'Unknown', taskStatus: task12Data['TaskStatus']?? 'Unknown',),
              SPProfileData(userPicture: task12Data['UserPicture']?? 'images/profilePic96.png', rating: (task12Data['Rating'] as num?)?.toDouble() ?? 0.0, numReviews: task12Data['ReviewCount']?? 0, userName:task12Data['Username']?? 'Unknown',),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFF6781A6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          border: Border.all(
                            color: Color(0xFF2F4771),
                            width: 1.0,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Home Owner Needs",
                            style: TextStyle(
                                color: Color(0xFFF9FAFB),
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8, top: 10, bottom: 8),
                              child: Text(
                                "Choose Tile Type For The Following: ",
                                style: TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8 ,right: 8),
                                    child: Text(
                                      "Bathroom Tile:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    await openCatalog() ;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5 , right: 5),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2F4771),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 12 , right: 8),
                                          child: Icon(
                                            Icons.folder_copy,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            "Open Catalog",
                                            style: TextStyle(
                                              color: Color(0xFFF9FAFB),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8 ,right: 8),
                                    child: Text(
                                      "House Tile:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async{
                                    await openCatalog() ;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5 , right: 5),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2F4771),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 12 , right: 8),
                                          child: Icon(
                                            Icons.folder_copy,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            "Open Catalog",
                                            style: TextStyle(
                                              color: Color(0xFFF9FAFB),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFF6781A6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                          border: Border.all(
                            color: Color(0xFF2F4771),
                            width: 1.0,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Service Provider Details",
                            style: TextStyle(
                                color: Color(0xFFF9FAFB),
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Service Provider Notes: ",
                                style: TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            Container(
                              height: 140,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                maxLines: 5,
                                minLines: 5,
                                enabled: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText:  task12Data['Notes'] ?? 'No notes available',
                                  hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2F4771),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2F4771),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 250,
                margin: EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF2F4771),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF9FAFB),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
