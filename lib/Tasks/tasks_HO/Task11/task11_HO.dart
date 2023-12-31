import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Tasks/taskWidgets/openCatalogSP.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/taskWidgets/catalogDialog.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/homeOwnerTasksAPI.dart';


void main() {
  runApp(GetMaterialApp(home: DoorFrameInstallHO()));
}

class DoorFrameInstallHO extends StatefulWidget {
  const DoorFrameInstallHO({super.key});

  @override
  State<DoorFrameInstallHO> createState() => _DoorFrameInstallHOState();
}

class _DoorFrameInstallHOState extends State<DoorFrameInstallHO> {

  List<Map<String, dynamic>> userChoices = [];


  Map<String, dynamic> task10Data = {};
  String taskID = '';
  String taskProjectId = '';

  int? bedroomDoorCatalogID;
  int? bathroomDoorCatalogID;
  int? livingroomDoorCatalogID;
  int? guestroomDoorCatalogID;

  late Map<String, dynamic> projectInfoData ;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task10Data = arguments['task10data'] ;
      projectInfoData = arguments['ProjectInfo'] ;
    });
    // print(task10Data) ;
    fetchArgumentsAndData();
  }

  Future<void> fetchArgumentsAndData() async {
    try {
      setState(() {

        bedroomDoorCatalogID = projectInfoData['BedroomDoor'] != null
            ? int.tryParse(projectInfoData['BedroomDoor'])
            : 0;

        bathroomDoorCatalogID = projectInfoData['BathroomDoor'] != null
            ? int.tryParse(projectInfoData['BathroomDoor'])
            : 0;

        livingroomDoorCatalogID = projectInfoData['LivingroomDoor'] != null
            ? int.tryParse(projectInfoData['LivingroomDoor'])
            : 0;

        guestroomDoorCatalogID = projectInfoData['GuestroomDoor'] != null
            ? int.tryParse(projectInfoData['GuestroomDoor'])
            : 0;

      });

    } catch (e) {
      print('Error fetching task10 data: $e');
    }
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
              TaskInformation(taskID: task10Data['TaskID']?? 0, taskName: task10Data['TaskName']?? 'Unknown', projectName: task10Data['ProjectName']?? 'Unknown', taskStatus: task10Data['TaskStatus']?? 'Unknown',),
              SPProfileData(userPicture: task10Data['UserPicture']?? 'images/profilePic96.png', rating: (task10Data['Rating'] as num?)?.toDouble() ?? 0.0, numReviews: task10Data['ReviewCount']?? 0, userName:task10Data['Username']?? 'Unknown',),
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
                                "Choose Door Design For The Following: ",
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
                                      "Bedroom Door:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                bedroomDoorCatalogID != 0
                                    ?
                                GestureDetector(
                                  onTap: () async{
                                    final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(bedroomDoorCatalogID.toString());
                                    Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
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
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Text(
                                            "See Item",
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
                                )
                                    :
                                SizedBox(),
                                GestureDetector(
                                  onTap: () async{
                                    // await openCatalog();
                                    final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task10Data['UserID'].toString());
                                    final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                    setState(() {
                                      bedroomDoorCatalogID = choosenID ;
                                    });
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
                                      "Bathroom Door:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                bathroomDoorCatalogID != 0
                                    ?
                                GestureDetector(
                                  onTap: ()async{
                                    final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(bathroomDoorCatalogID.toString());
                                    Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
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
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "See Item",
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
                                )
                                    :
                                SizedBox(),
                                GestureDetector(
                                  onTap: () async{
                                    // await openCatalog();
                                    final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task10Data['UserID'].toString());
                                    final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                    setState(() {
                                      bedroomDoorCatalogID = choosenID ;
                                    });
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
                                      "Living Room Door:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                livingroomDoorCatalogID != 0
                                    ?
                                GestureDetector(
                                  onTap: () async{
                                    final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(livingroomDoorCatalogID.toString());
                                    Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
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
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            "See Item",
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
                                )
                                    :
                                SizedBox(),
                                GestureDetector(
                                  onTap: () async{
                                    final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task10Data['UserID'].toString());
                                    final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                    setState(() {
                                      livingroomDoorCatalogID = choosenID ;
                                    });
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
                                      "Guest Room Door:",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                                guestroomDoorCatalogID != 0
                                    ?
                                GestureDetector(
                                  onTap: () async{
                                    final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(guestroomDoorCatalogID.toString());
                                    Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
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
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            "See Item",
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
                                )
                                    :
                                SizedBox(),
                                GestureDetector(
                                  onTap: () async{
                                    final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task10Data['UserID'].toString());
                                    final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                    setState(() {
                                      guestroomDoorCatalogID = choosenID ;
                                    });
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
                                "Provider Notes: ",
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
                                  hintText:  task10Data['Notes'] ?? 'No notes available',
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
                  onPressed: () {
                    /*
                    here i want to save the value of them in db
                     */
                  },
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
