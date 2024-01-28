import 'package:buildnex/Tasks/taskWidgets/sp_catalogDialog.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../APIRequests/serviceProviderCatalogAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../../classes/language_constants.dart';

void main() {
  runApp(GetMaterialApp(home: DoorFrameInstallSP()));
}

class DoorFrameInstallSP extends StatefulWidget {
  const DoorFrameInstallSP({super.key});

  @override
  State<DoorFrameInstallSP> createState() => _DoorFrameInstallSPSPState();
}

class _DoorFrameInstallSPSPState extends State<DoorFrameInstallSP> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> doorFrameData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      doorFrameData = arguments['task10Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (doorFrameData['TaskStatus'] == 'Completed') {
        setState(() {
          isSubmitVisible = false;
        });
      }

      if (doorFrameData['Notes'] != null) {
        _userNotes.text = doorFrameData['Notes'];
      } else {
        _userNotes.text = '';
      }
    });
  }

  bool areFieldsValid(String userNotes) {
    if (userNotes.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> openCatalog(String itemID, context) async {
    final isRtl = !(translation(context)!.localeName == 'ar');

    Map<String, dynamic> itemDetails = {};
    if (itemID == 'null') {
      Get.snackbar(
        '',
        '',
        titleText: Text(
          translation(context)!.sp_task10snackbarTitle,
          textAlign: isRtl ? TextAlign.left : TextAlign.right,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          translation(context)!.sp_task10snackbarContent,
          textAlign: isRtl ? TextAlign.left : TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2F4771),
      );

    } else {
      itemDetails = await CatalogAPI.getItemDetails(itemID);
      await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (BuildContext context) {
          return CatalogDialogSP(
            itemDetails: itemDetails,
          );
        },
      );
    }

  }

  String translateTaskStatus(String status, BuildContext context) {
    switch (status) {
      case 'Not Started':
        return translation(context)!.taskStatusNotStarted;
      case 'In Progress':
        return translation(context)!.taskStatusInProgress;
      case 'Completed':
        return translation(context)!.taskStatusCompleted;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = !(translation(context)!.localeName == 'ar');
    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child:  WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed('/HomePage/ServiceProvider') ;
        return true ;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFF3D69B),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: Text(
              translation(context)!.sp_taskTitle,
              style: const TextStyle(color: Color(0xFFF3D69B)),
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
                  taskID: doorFrameData['TaskID'] ?? 0,
                  taskName: translation(context)!.sp_task10Name,
                  projectName: doorFrameData['ProjectName'] ?? 'Unknown',
                  taskStatus: translateTaskStatus(doorFrameData['TaskStatus'], context),
                ),
                TaskProviderInformation(
                  userPicture: doorFrameData['UserPicture'],
                  rating: (doorFrameData['Rating'] as num?)?.toDouble() ?? 0.0,
                  numOfReviews: doorFrameData['ReviewCount'] ?? 0,
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
                          child:  Center(
                            child: Text(
                                translation(context)!.sp_task10homeownerNeeds,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task10BedroomDoor,
                                        style:  TextStyle(
                                            color: const Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500: FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(doorFrameData['BedroomDoor']!=null){
                                        await openCatalog(doorFrameData['BedroomDoor'].toString(),context);
                                      }
                                      else{
                                        await openCatalog('null',context);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Icon(
                                              Icons.file_open,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0) :  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.sp_task10Details,
                                              style: const TextStyle(
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task10BathroomDoor,
                                        style:  TextStyle(
                                            color: const Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500: FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(doorFrameData['BathroomDoor']!=null){
                                        await openCatalog(doorFrameData['BathroomDoor'].toString(),context);
                                      }
                                      else{
                                        await openCatalog('null',context);
                                      }

                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Icon(
                                              Icons.file_open,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0) :  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.sp_task10Details,
                                              style: const TextStyle(
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
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task10LivingDoor,
                                        style:  TextStyle(
                                            color: const Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500: FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(doorFrameData['LivingroomDoor']!=null){
                                        await openCatalog(doorFrameData['LivingroomDoor'].toString(),context);
                                      }
                                      else{
                                        await openCatalog('null',context);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Icon(
                                              Icons.file_open,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0) :  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.sp_task10Details,
                                              style: const TextStyle(
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
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                       translation(context)!.sp_task10GuestDoor,
                                        style:  TextStyle(
                                            color: const Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500: FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if(doorFrameData['GuestroomDoor']!=null){
                                        await openCatalog(doorFrameData['GuestroomDoor'].toString(),context);
                                      }
                                      else{
                                        await openCatalog('null',context);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Icon(
                                              Icons.file_open,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0) :  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.sp_task10Details,
                                              style: const TextStyle(
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
                          child:  Center(
                            child: Text(
                              translation(context)!.sp_taskTitle,
                              style: const TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: 5, left: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        translation(context)!.yourNotes,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: TextFormField(
                                        maxLines: 5,
                                        minLines: 5,
                                        controller: _userNotes,
                                        style:
                                            TextStyle(color: Color(0xFF2F4771)),
                                        decoration: InputDecoration(
                                          hintText: translation(context)!.enterNotesHere,
                                          hintStyle:
                                              TextStyle(color: Color(0xFF2F4771)),
                                          filled: true,
                                          fillColor: Color(0xFFF9FAFB),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF2F4771),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF2F4771),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2F4771),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                            ),
                                            child: TextButton(
                                              onPressed: () async {
                                                await ServiceProviderGetTasksAPI
                                                    .setTask6Data(
                                                  taskID,
                                                  _userNotes.text,
                                                  'Update Data',
                                                  taskProjectId,
                                                );
                                              },
                                              child: Text(
                                                translation(context)!.save,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xFFF9FAFB),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (isSubmitVisible)
                                          Expanded(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF2F4771),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30.0)),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    if (areFieldsValid(_userNotes.text)) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Directionality(
                                                            textDirection: translation(context)!.localeName == 'ar'
                                                                ? TextDirection.rtl
                                                                : TextDirection.ltr,
                                                            child: AlertDialog(
                                                              backgroundColor: Colors.white,
                                                              title: Text(translation(context)!.completeTask),
                                                              content: Text(translation(context)!.clickOkToComplete),
                                                              actions: [
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: Color(0xFFF3D69B),
                                                                  ),
                                                                  onPressed: () async {
                                                                    String message = await ServiceProviderGetTasksAPI.setTask6Data(
                                                                      taskID,
                                                                      _userNotes.text,
                                                                      'Submit',
                                                                      taskProjectId,
                                                                    );
                                                                    setState(() {
                                                                      doorFrameData['TaskStatus'] = 'Completed';
                                                                      isSubmitVisible = false;
                                                                    });
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text(
                                                                    translation(context)!.clickOk,
                                                                    style: const TextStyle(color: Color(0xFF2F4771), fontSize: 15),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: Color(0xFFF3D69B),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text(
                                                                    translation(context)!.customCancel,
                                                                    style: const TextStyle(color: Color(0xFF2F4771), fontSize: 15),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      CustomAlertDialog.showErrorDialog(
                                                          context,
                                                          translation(context)!.customFill
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    translation(context)!.markAsDone,
                                                    style: const TextStyle(fontSize: 18, color: Color(0xFFF9FAFB)),
                                                  ),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
    ),
    );
  }
}
