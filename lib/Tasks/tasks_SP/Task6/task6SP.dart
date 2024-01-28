import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../../classes/language_constants.dart';
import '../../taskWidgets/Information.dart';
import '../../taskWidgets/designAndPlanningInformation.dart';

void main() {
  runApp(GetMaterialApp(home: ConstructionSP()));
}

class ConstructionSP extends StatefulWidget {
  const ConstructionSP({super.key});

  @override
  State<ConstructionSP> createState() => _ConstructionSPState();
}

class _ConstructionSPState extends State<ConstructionSP> {
  String _materialProvider = 'Select an Option';
  final _userNotes = TextEditingController();

  Map<String, dynamic> constructionData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      constructionData = arguments['task6Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (constructionData['TaskStatus'] == 'Completed') {
        setState(() {
          isSubmitVisible = false;
        });
      }
      if (constructionData['Notes'] != null) {
        _userNotes.text = constructionData['Notes'];
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

  String translateTaskProvider(String status, BuildContext context) {
    switch (status) {
      case 'Service Provider':
        return translation(context)!.sp_task6ServiceChosen;
      case 'Me -HomeOwner-':
        return translation(context)!.sp_task6HomeChosen;
      case '':
        return translation(context)!.sp_task4Chosen;
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
     child: WillPopScope(
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
            child:  Text(
            translation(context)!.sp_taskTitle,
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
                TaskInformation(
                  taskID: constructionData['TaskID'] ?? 0,
                  taskName: translation(context)!.sp_task6Name,
                  projectName: constructionData['ProjectName'] ?? 'Unknown',
                  taskStatus: translateTaskStatus(constructionData['TaskStatus'], context),
                ),
                DesignAndPlanningInformation(
                  title: translation(context)!.task2_InformationTitle2,
                  documentName1:translation(context)!.sp_task6Arch,
                  document1: constructionData['FoundationDocument'] ?? 'Unknown',
                  documentName2: translation(context)!.sp_task6Civil,
                  document2: constructionData['InsulationAndHVACDocument'] ?? 'Unknown',
                ),
                TaskProviderInformation(
                  userPicture: constructionData['UserPicture'],
                  rating: (constructionData['Rating'] as num?)?.toDouble() ?? 0.0,
                  numOfReviews: constructionData['ReviewCount'] ?? 0,
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
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task6Provider,
                                        style:  TextStyle(
                                            color: const Color(0xFF2F4771),
                                            fontWeight: isRtl
                                                ? FontWeight.w500
                                                : FontWeight.w800,
                                            fontSize: isRtl ? 16 : 19),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                            color: Color(0xFF2F4771), width: 1.8),
                                      ),
                                      child: Center(
                                        child: Text(
                                            translateTaskProvider(constructionData['MaterialProvider']??'',context) ,
                                          style: const TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        translation(context)!
                                            .yourNotes,
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
                                          hintText: translation(context)!
                                              .enterNotesHere,
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
                                                                      constructionData['TaskStatus'] = 'Completed';
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
                                    const SizedBox(
                                      height: 5,
                                    )
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
