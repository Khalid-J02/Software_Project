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
  runApp(GetMaterialApp(home: PaintingHO()));
}

class PaintingHO extends StatefulWidget {
  const PaintingHO({super.key});

  @override
  State<PaintingHO> createState() => _PaintingHOState();
}

class _PaintingHOState extends State<PaintingHO> {
  List<Map<String, dynamic>> userChoices = [];
  Map<String, dynamic> task15Data = {};
  String taskID = '';
  String taskProjectId = '';

  int? bedroomPaintCatalogID;
  int? bathroomPaintCatalogID;
  int? livingroomPaintCatalogID;
  int? guestroomPaintCatalogID;
  int? kitchenPaintCatalogID;

  late Map<String, dynamic> projectInfoData;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task15Data = arguments['task15data'];
      projectInfoData = arguments['projectInfo'];
    });
    fetchArgumentsAndData();
  }

  Future<void> fetchArgumentsAndData() async {
    try {
      setState(() {
        print(projectInfoData);
        bedroomPaintCatalogID = projectInfoData['BedroomPaint'] != null
            ? projectInfoData['BedroomPaint']
            : 0;

        bathroomPaintCatalogID = projectInfoData['BathroomPaint'] != null
            ? projectInfoData['BathroomPaint']
            : 0;

        livingroomPaintCatalogID = projectInfoData['LivingroomPaint'] != null
            ? projectInfoData['LivingroomPaint']
            : 0;

        guestroomPaintCatalogID = projectInfoData['GuestroomPaint'] != null
            ? projectInfoData['GuestroomPaint']
            : 0;

        kitchenPaintCatalogID = projectInfoData['KitchenPaint'] != null
            ? projectInfoData['KitchenPaint']
            : 0;
      });
    } catch (e) {
      print('Error fetching task15 data: $e');
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
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: Text(
              translation(context)!.task1HOMainTitle,
              style: TextStyle(color: Colors.white),
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
                  taskID: task15Data['TaskID'] ?? 0,
                  taskName: translation(context)!.task13HOTaskName,
                  projectName: task15Data['ProjectName'] ?? 'Unknown',
                  taskStatus: task15Data['TaskStatus'] ?? 'Unknown',
                ),
                SPProfileData(
                  userPicture:
                      task15Data['UserPicture'] ?? 'images/profilePic96.png',
                  rating: (task15Data['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: task15Data['ReviewCount'] ?? 0,
                  userName: task15Data['Username'] ?? 'Unknown',
                  taskId: taskID,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                              translation(context)!.task11HONeeds,
                              style: TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 8, top: 10, bottom: 8),
                                child: Text(
                                  translation(context)!.task13HONeedsSubTitle,
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        translation(context)!.task13HONeedsBedroom,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  bedroomPaintCatalogID != 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            final Map<String, dynamic>
                                                itemDetails =
                                                await CatalogAPI.getItemDetails(
                                                    bedroomPaintCatalogID
                                                        .toString());
                                            Get.to(SPCatalogItem_HO(
                                              itemDetails: itemDetails,
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  EdgeInsets.only(
                                                      left: 4, right: 8)
                                                      :
                                                  EdgeInsets.only(
                                                      left: 8, right: 4),
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  translation(context)!.localeName == 'ar'
                                                      ? EdgeInsets.only(left: 8)
                                                      : EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    translation(context)!.task13HONeedsSeeItem,
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
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () async {
                                      final List<Map<String, dynamic>> SPCatalog =
                                          await ServiceProviderDataAPI
                                              .getServiceProCatalogItems(
                                                  task15Data['UserID']
                                                      .toString());
                                      final int? choosenID = await Get.to(
                                          OpenCatalogSP(),
                                          arguments: SPCatalog);
                                      setState(() {
                                        bedroomPaintCatalogID = choosenID;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            EdgeInsets.only(
                                                left: 4, right: 12)
                                                :EdgeInsets.only(
                                                left: 12, right: 4),
                                            child: Icon(
                                              Icons.folder_copy,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ? EdgeInsets.only(left: 12)
                                                : EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.task13HONeedsOpenCatalog,
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        translation(context)!.task13HONeedsBathroom,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  bathroomPaintCatalogID != 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            final Map<String, dynamic>
                                                itemDetails =
                                                await CatalogAPI.getItemDetails(
                                                    bathroomPaintCatalogID
                                                        .toString());
                                            Get.to(SPCatalogItem_HO(
                                              itemDetails: itemDetails,
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  EdgeInsets.only(
                                                      left: 4, right: 8)
                                                      :
                                                  EdgeInsets.only(
                                                      left: 8, right: 4),
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  translation(context)!.localeName == 'ar'
                                                      ? EdgeInsets.only(left: 8)
                                                      : EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    translation(context)!.task13HONeedsSeeItem,
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
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () async {
                                      final List<Map<String, dynamic>> SPCatalog =
                                          await ServiceProviderDataAPI
                                              .getServiceProCatalogItems(
                                                  task15Data['UserID']
                                                      .toString());
                                      final int? choosenID = await Get.to(
                                          OpenCatalogSP(),
                                          arguments: SPCatalog);
                                      setState(() {
                                        bathroomPaintCatalogID = choosenID;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            EdgeInsets.only(
                                                left: 4, right: 12)
                                                :EdgeInsets.only(
                                                left: 12, right: 4),
                                            child: Icon(
                                              Icons.folder_copy,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ? EdgeInsets.only(left: 12)
                                                : EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.task13HONeedsOpenCatalog,
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        translation(context)!.task13HONeedsLivingRoom,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  livingroomPaintCatalogID != 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            final Map<String, dynamic>
                                                itemDetails =
                                                await CatalogAPI.getItemDetails(
                                                    livingroomPaintCatalogID
                                                        .toString());
                                            Get.to(SPCatalogItem_HO(
                                              itemDetails: itemDetails,
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  EdgeInsets.only(
                                                      left: 4, right: 8)
                                                      :
                                                  EdgeInsets.only(
                                                      left: 8, right: 4),
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  translation(context)!.localeName == 'ar'
                                                      ? EdgeInsets.only(left: 8)
                                                      : EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    translation(context)!.task13HONeedsSeeItem,
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
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () async {
                                      final List<Map<String, dynamic>> SPCatalog =
                                          await ServiceProviderDataAPI
                                              .getServiceProCatalogItems(
                                                  task15Data['UserID']
                                                      .toString());
                                      final int? choosenID = await Get.to(
                                          OpenCatalogSP(),
                                          arguments: SPCatalog);
                                      setState(() {
                                        livingroomPaintCatalogID = choosenID;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            EdgeInsets.only(
                                                left: 4, right: 12)
                                                :EdgeInsets.only(
                                                left: 12, right: 4),
                                            child: Icon(
                                              Icons.folder_copy,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ? EdgeInsets.only(left: 12)
                                                : EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.task13HONeedsOpenCatalog,
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        translation(context)!.task13HONeedsGuestRoom,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  guestroomPaintCatalogID != 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            final Map<String, dynamic>
                                                itemDetails =
                                                await CatalogAPI.getItemDetails(
                                                    guestroomPaintCatalogID
                                                        .toString());
                                            Get.to(SPCatalogItem_HO(
                                              itemDetails: itemDetails,
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  EdgeInsets.only(
                                                      left: 4, right: 8)
                                                      :
                                                  EdgeInsets.only(
                                                      left: 8, right: 4),
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  translation(context)!.localeName == 'ar'
                                                      ? EdgeInsets.only(left: 8)
                                                      : EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    translation(context)!.task13HONeedsSeeItem,
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
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () async {
                                      final List<Map<String, dynamic>> SPCatalog =
                                          await ServiceProviderDataAPI
                                              .getServiceProCatalogItems(
                                                  task15Data['UserID']
                                                      .toString());
                                      final int? choosenID = await Get.to(
                                          OpenCatalogSP(),
                                          arguments: SPCatalog);
                                      setState(() {
                                        guestroomPaintCatalogID = choosenID;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            EdgeInsets.only(
                                                left: 4, right: 12)
                                                :EdgeInsets.only(
                                                left: 12, right: 4),
                                            child: Icon(
                                              Icons.folder_copy,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ? EdgeInsets.only(left: 12)
                                                : EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.task13HONeedsOpenCatalog,
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 6),
                                      child: Text(
                                        translation(context)!.task13HONeedsKitchen,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  kitchenPaintCatalogID != 0
                                      ? GestureDetector(
                                          onTap: () async {
                                            final Map<String, dynamic>
                                                itemDetails =
                                                await CatalogAPI.getItemDetails(
                                                    kitchenPaintCatalogID
                                                        .toString());
                                            Get.to(SPCatalogItem_HO(
                                              itemDetails: itemDetails,
                                            ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  EdgeInsets.only(
                                                      left: 4, right: 8)
                                                      :
                                                  EdgeInsets.only(
                                                      left: 8, right: 4),
                                                  child: Icon(
                                                    Icons.remove_red_eye,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  translation(context)!.localeName == 'ar'
                                                      ? EdgeInsets.only(left: 8)
                                                      : EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    translation(context)!.task13HONeedsSeeItem,
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
                                      : SizedBox(),
                                  GestureDetector(
                                    onTap: () async {
                                      final List<Map<String, dynamic>> SPCatalog =
                                          await ServiceProviderDataAPI
                                              .getServiceProCatalogItems(
                                                  task15Data['UserID']
                                                      .toString());
                                      final int? choosenID = await Get.to(
                                          OpenCatalogSP(),
                                          arguments: SPCatalog);
                                      setState(() {
                                        kitchenPaintCatalogID = choosenID;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            EdgeInsets.only(
                                                left: 4, right: 12)
                                                :EdgeInsets.only(
                                                left: 12, right: 4),
                                            child: Icon(
                                              Icons.folder_copy,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ? EdgeInsets.only(left: 12)
                                                : EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.task13HONeedsOpenCatalog,
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
                              const SizedBox(
                                height: 10,
                              ),
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
                                      await HomeOwnerTasksAPI.saveProjectInfoPaints(
                                          taskProjectId ,
                                          bedroomPaintCatalogID ,
                                          bathroomPaintCatalogID ,
                                          livingroomPaintCatalogID ,
                                          guestroomPaintCatalogID ,
                                          kitchenPaintCatalogID
                                      );
                                    },
                                    child: Text(
                                      translation(context)!.task11HONeedsSaveLabelButton,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                  fontWeight: FontWeight.bold),
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
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                height: 140,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  maxLines: 5,
                                  minLines: 5,
                                  enabled: false,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: task15Data['Notes'] ??
                                        translation(context)!.task1HONoNotesSP,
                                    hintStyle:
                                        TextStyle(color: Color(0xFF2F4771)),
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
                              const SizedBox(
                                height: 10,
                              ),
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
