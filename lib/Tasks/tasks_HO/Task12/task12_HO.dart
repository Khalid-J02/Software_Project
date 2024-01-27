import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/APIRequests/homeOwnerTasksAPI.dart';
import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Tasks/taskWidgets/openCatalogSP.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



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

  late Map<String, dynamic> projectInfoData ;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task12Data = arguments['task12data'];
      projectInfoData = arguments['projectInfo'];
    });
    fetchArgumentsAndData();
  }

  Future<void> fetchArgumentsAndData() async {
    try {
      setState(() {
        bathroomTileCatalogID = projectInfoData['BathroomTile'] != null
            ? projectInfoData['BathroomTile']
            : 0;

        houseTileCatalogID = projectInfoData['HouseTile'] != null
            ? projectInfoData['HouseTile']
            : 0;
      });
    } catch (e) {
      print('Error fetching task12 data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
            child: Text(
              translation(context)!.task1HOMainTitle,
              style: const TextStyle(color: Colors.white),
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
                TaskInformation(
                  taskID: task12Data['TaskID']?? 0,
                  taskName: 'Tile Work',
                  projectName: task12Data['ProjectName']?? 'Unknown',
                  taskStatus: task12Data['TaskStatus']?? 'Unknown',
                ),
                SPProfileData(
                  userPicture: task12Data['UserPicture']?? 'images/profilePic96.png',
                  rating: (task12Data['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: task12Data['ReviewCount']?? 0,
                  userName:task12Data['Username']?? 'Unknown',
                  taskId: taskID,
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
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        "Bathroom:",
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                  bathroomTileCatalogID != 0
                                      ?
                                  GestureDetector(
                                    onTap: () async{
                                      final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(bathroomTileCatalogID.toString());
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
                                                fontSize: 14,
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
                                      final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task12Data['UserID'].toString());
                                      final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                      setState(() {
                                        bathroomTileCatalogID = choosenID ;
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
                                                fontSize: 14,
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
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        "House:",
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      ),
                                    ),
                                  ),
                                  houseTileCatalogID != 0
                                      ?
                                  GestureDetector(
                                    onTap: () async{
                                      final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(houseTileCatalogID.toString());
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
                                                fontSize: 14,
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
                                      final List<Map<String, dynamic>> SPCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(task12Data['UserID'].toString());
                                      final int? choosenID = await Get.to(OpenCatalogSP() , arguments: SPCatalog);
                                      setState(() {
                                        houseTileCatalogID = choosenID ;
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
                                                fontSize: 14,
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
                              Center(
                                child: Container(
                                  width: 250,
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2F4771),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      await HomeOwnerTasksAPI.saveProjectInfoTiles(taskProjectId , bathroomTileCatalogID , houseTileCatalogID);
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
                              ),
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
                          child: Center(
                            child: Text(
                              translation(context)!.task1HOServiceProviderDetailsTitle,
                              style: const TextStyle(
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
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  translation(context)!.task1HOServiceProviderNotes,
                                  style: const TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
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
                                    hintText:  task12Data['Notes'] ??
                                        translation(context)!.task1HONoNotesSP,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
