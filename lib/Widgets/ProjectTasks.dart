import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/materialProvidersList.dart';
import 'package:buildnex/screens/searchPage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/NavbarProjectPageHomeOwnerAPI.dart';
import '../APIRequests/homeOwnerTasksAPI.dart';
import 'customAlertDialog.dart';

class ProjectTasks extends StatefulWidget {
  final String taskProjectId;
  final String taskID;
  final String taskName;
  late  String taskStatus;
  final String taskDescription;
  final String taskNumber;
  final String? serviceProviderID;
  final String? serviceProviderName;

  ProjectTasks({
    Key? key,
    required this.taskProjectId,
    required this.taskID,
    required this.taskName,
    required this.taskStatus,
    required this.taskDescription,
    required this.taskNumber,
    this.serviceProviderID,
    this.serviceProviderName,
  }) : super(key: key);

  @override
  State<ProjectTasks> createState() => _ProjectTasksState();
}

class _ProjectTasksState extends State<ProjectTasks> {
  late String serviceType;

  late String projectEntryPoint;

  late String serviceTypeMaterial;

  final Set<String> tasksToShowProviders = {
    '6',
    '10',
    '12',
    '13',
    '14',
    '15',
  };

  late String buttonLabel;
  late VoidCallback buttonAction;
  late Color borderColor;

  Color getBorderColorBasedOnStatus(String status) {
    if (status == 'Not Started' || status == 'لم تبدأ') {
      return const Color(0xFFB22D00);
    } else if (status == 'In Progress' || status == 'قيد التنفيذ') {
      return const Color(0xFFFF9637);
    } else {
      return const Color(0xFF2BD066);
    }
  }

  @override
  Widget build(BuildContext context) {
    borderColor = getBorderColorBasedOnStatus(widget.taskStatus);

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.taskName,
                      style: TextStyle(
                        fontSize: translation(context)!.localeName == 'ar' ? 20 : 18,
                        color: const Color(0xFFF3D69B),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Tooltip(
                      message: widget.taskDescription,
                      padding: const EdgeInsets.all(12),
                      showDuration: const Duration(seconds: 10),
                      textStyle: const TextStyle(color: Colors.white),
                      decoration: const BoxDecoration(color: Color(0xFF122247)),
                      preferBelow: false,
                      verticalOffset: 10,
                      child: const Icon(
                        Icons.info,
                        color: Color(0xFFF3D69B),
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: getBorderColorBasedOnStatus(widget.taskStatus),
                      // color: Color(0xFFF9FAFB),
                      size: 18,
                    ),
                    Text(
                      " ${widget.taskStatus}",
                      style: TextStyle(
                        fontSize: 14,
                        color: getBorderColorBasedOnStatus(widget.taskStatus),
                        //color: Color(0xFFF9FAFB),
                      ),
                    ),
                  ],
                ),
              ),

              // FutureBuilder for Task 16
              FutureBuilder<String>(
                future: HomeOwnerTasksAPI.checkPreviousTaskStatus(
                    int.parse(widget.taskProjectId), int.parse('16')),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (widget.taskNumber == '16') {
                      if (snapshot.data == 'Completed') {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 33,
                              width: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3D69B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              child: TextButton(
                                onPressed: () async {
                                  List<dynamic> materialProviders =
                                      await HomeOwnerTasksAPI
                                          .getMaterialProviders('Finishing');
                                  Get.to(() => MaterialProvidersList(
                                      materialProvidersData: materialProviders));
                                },
                                child: const Text(
                                  "Material Prov..",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF122247),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 33,
                              width: 85,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3D69B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Static Task'),
                                        content: Text(widget.taskDescription),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              // Close the dialog
                                             await HomeOwnerTasksAPI.markTask16asDone(widget.taskID,widget.taskProjectId);
                                             setState(() {
                                               widget.taskStatus='Completed';
                                               borderColor = getBorderColorBasedOnStatus(widget.taskStatus);
                                             });
                                              Navigator.of(context).pop();
                                            },
                                            child:
                                                const Text('Mark Task As Done'),
                                          ),
                                          TextButton(
                                            onPressed: () {

                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                },
                                child: const Text(
                                  "Open Task",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF122247),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // "Add Provider" button for Task 16 when not completed
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 170,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3D69B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(
                                  bottom: 5, top: 5,),
                              child: TextButton(
                                onPressed: () {
                                  CustomAlertDialog.showErrorDialog(context,
                                      'You can not go to the next task before complete previous one.');
                                  return;
                                },
                                child: const Text(
                                  "Add Service Provider",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF122247),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return Container(); // For task numbers other than 16
                    }
                  } else {
                    // While waiting for the Future to complete
                    return CircularProgressIndicator();
                  }
                },
              ),

              if (widget.serviceProviderID != 'No Provider ID' && widget.taskNumber != '16')
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outline_rounded,
                            color: Color(0xFFF9FAFB),
                            size: 18,
                          ),
                          Text(
                            " ${widget.serviceProviderName}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFFF9FAFB),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (tasksToShowProviders.contains(widget.taskNumber))
                            Container(
                              height: 45,
                              width: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3D69B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 5, top: 5),
                              child: TextButton(
                                onPressed: () async {
                                  if (int.parse(widget.taskNumber) == 6) {
                                    serviceTypeMaterial = "Constructor";
                                  } else if (int.parse(widget.taskNumber) == 7) {
                                    serviceTypeMaterial = "Plumbing Technician";
                                  } else if (int.parse(widget.taskNumber) == 8) {
                                    serviceTypeMaterial = "Electrical Technician";
                                  } else if (int.parse(widget.taskNumber) == 9) {
                                    serviceTypeMaterial = "Insulation Technician";
                                  } else if (int.parse(widget.taskNumber) == 10) {
                                    serviceTypeMaterial = "Carpenter";
                                  } else if (int.parse(widget.taskNumber) == 12) {
                                    serviceTypeMaterial = "Tile Contractor";
                                  } else if (int.parse(widget.taskNumber) == 13) {
                                    serviceTypeMaterial = "Window Installer";
                                  } else if (int.parse(widget.taskNumber) == 14) {
                                    serviceTypeMaterial = "Carpenter";
                                  } else if (int.parse(widget.taskNumber) == 15) {
                                    serviceTypeMaterial = "Painter";
                                  }

                                  List<dynamic> materialProviders =
                                      await HomeOwnerTasksAPI
                                          .getMaterialProviders(
                                              serviceTypeMaterial);
                                  Get.to(MaterialProvidersList(
                                      materialProvidersData: materialProviders));
                                },
                                child: Text(
                                  translation(context)!.homeOwnerProjectTasksMaterialProv,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF122247),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 45,
                            width: 85,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3D69B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: TextButton(
                              onPressed: () async {
                                // here you will move to tasks like task1 2 3 etc
                                final Map<String, dynamic> ProjectInfo =
                                    await HomeOwnerTasksAPI.getProjectInfoData(
                                        int.parse(widget.taskProjectId));

                                String path = '/HomeOwnerTasks/Task' + widget.taskNumber;
                                // print(taskNumber) ;
                                if (widget.taskNumber == '1') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getPropertySurvey(
                                          widget.taskID);
                                  final String? _docsURL =
                                      await HomeOwnerTasksAPI.getSurveyDocument(
                                          widget.taskProjectId);

                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'propertySurveyData': data,
                                    'docsURL': _docsURL
                                  });
                                }
                                if (widget.taskNumber == '2') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI
                                          .getPermitsRegulatoryInfo(widget.taskID);
                                  final String? _docsURL =
                                      await HomeOwnerTasksAPI.getPermitsDocument(
                                          widget.taskProjectId);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'localGovernmentData': data,
                                    'docsURL': _docsURL
                                  });
                                }
                                if (widget.taskNumber == '3') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI
                                          .getSoilInvestigation(widget.taskID);
                                  final String? _docsURL =
                                      await HomeOwnerTasksAPI.getSoilDocument(
                                          widget.taskProjectId);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'soilTesting': data,
                                    'docsURL': _docsURL
                                  });
                                }
                                if (widget.taskNumber == '4') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI
                                          .getDesignAndPlanning(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'DesignData': data,
                                    'buildingData': ProjectInfo,
                                  });
                                }
                                if (widget.taskNumber == '5') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getApprovals(
                                          widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'GovernmentData': data,
                                  });
                                }
                                if (widget.taskNumber == '6') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'taskData': data,
                                    'projectData': ProjectInfo
                                  });
                                }
                                if (widget.taskNumber == '7') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'datatask7': data,
                                  });
                                }
                                if (widget.taskNumber == '8') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task8data': data,
                                  });
                                }
                                if (widget.taskNumber == '9') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task9data': data,
                                  });
                                }
                                if (widget.taskNumber == '10') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task10data': data,
                                    'ProjectInfo': ProjectInfo
                                  });
                                }
                                if (widget.taskNumber == '11') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task11data': data,
                                  });
                                }
                                if (widget.taskNumber == '12') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task12data': data,
                                    'projectInfo': ProjectInfo
                                  });
                                }
                                if (widget.taskNumber == '13') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task13data': data,
                                    'projectInfo': ProjectInfo
                                  });
                                }
                                if (widget.taskNumber == '14') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task14data': data,
                                    'projectInfo': ProjectInfo
                                  });
                                }
                                if (widget.taskNumber == '15') {
                                  final Map<String, dynamic> data =
                                      await HomeOwnerTasksAPI.getTask6(widget.taskID);
                                  Get.toNamed(path, arguments: {
                                    'taskID': widget.taskID,
                                    'taskProjectId': widget.taskProjectId,
                                    'task15data': data,
                                    'projectInfo': ProjectInfo
                                  });
                                }
                              },
                              child: Text(
                                translation(context)!.homeOwnerProjectTasksOpenTask,
                                style: TextStyle(
                                  fontSize: translation(context)!.localeName == 'ar' ? 15 : 14,
                                  color: const Color(0xFF122247),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else if (widget.serviceProviderID == 'No Provider ID' &&
                  widget.taskNumber != '16')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3D69B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: TextButton(
                        onPressed: () async {
                          String previousTaskStatus;
                          final Map<String, dynamic> projectInfo =
                              await HomeOwnerProjectPageNavbarAPI.getProjectData(
                                  widget.taskProjectId);
                          if (projectInfo['ProjectEntryPoint'] ==
                              'From Scratch') {
                            if (int.parse(widget.taskNumber) > 1) {
                              previousTaskStatus =
                                  await HomeOwnerTasksAPI.checkPreviousTaskStatus(
                                      int.parse(widget.taskProjectId),
                                      int.parse(widget.taskNumber));

                              // Check the status of the previous task
                              if ((int.parse(widget.taskNumber) >= 7 &&
                                  int.parse(widget.taskNumber) <= 9)) {
                                previousTaskStatus = await HomeOwnerTasksAPI
                                    .checkPreviousTaskStatus(
                                        int.parse(widget.taskProjectId), int.parse("7"));

                                await CustomAlertDialog.showParallelTasksDialog(
                                    context);
                              }
                              if (int.parse(widget.taskNumber) == 10) {
                                previousTaskStatus = await HomeOwnerTasksAPI
                                    .checkPreviousTaskStatus(
                                        int.parse(widget.taskProjectId), int.parse("9"));
                              }

                              if (previousTaskStatus == "In Progress" ||
                                  previousTaskStatus == "Not Started") {
                                CustomAlertDialog.showErrorDialog(context,
                                    'You can not go to the next task before complete previous one.');
                                return;
                              }
                            }
                          } else if (projectInfo['ProjectEntryPoint'] ==
                              'From Middle') {
                            if (int.parse(widget.taskNumber) > 10) {
                              previousTaskStatus =
                                  await HomeOwnerTasksAPI.checkPreviousTaskStatus(
                                      int.parse(widget.taskProjectId),
                                      int.parse(widget.taskNumber));

                              if (previousTaskStatus == "In Progress" ||
                                  previousTaskStatus == "Not Started") {
                                CustomAlertDialog.showErrorDialog(context,
                                    'You can not go to the next task before complete previous one.');
                                return;
                              }
                            }
                          }

                          if (int.parse(widget.taskNumber) == 1) {
                            serviceType = "Surveyor";
                          } else if (int.parse(widget.taskNumber) >= 2 &&
                              int.parse(widget.taskNumber) <= 5) {
                            serviceType = "Engineering Office";
                          } else if (int.parse(widget.taskNumber) == 6) {
                            serviceType = "Constructor";
                          } else if (int.parse(widget.taskNumber) == 7) {
                            serviceType = "Plumbing Technician";
                          } else if (int.parse(widget.taskNumber) == 8) {
                            serviceType = "Electrical Technician";
                          } else if (int.parse(widget.taskNumber) == 9) {
                            serviceType = "Insulation Technician";
                          } else if (int.parse(widget.taskNumber) == 10) {
                            serviceType = "Carpenter";
                          } else if (int.parse(widget.taskNumber) == 11) {
                            serviceType = "Plasterer";
                          } else if (int.parse(widget.taskNumber) == 12) {
                            serviceType = "Tile Contractor";
                          } else if (int.parse(widget.taskNumber) == 13) {
                            serviceType = "Window Installer";
                          } else if (int.parse(widget.taskNumber) == 14) {
                            serviceType = "Carpenter";
                          } else if (int.parse(widget.taskNumber) == 15) {
                            serviceType = "Painter";
                          }
                          // Navigate to the next screen and pass taskID and serviceProviderID
                          Get.to(SearchPage(askForRequest: true), arguments: {
                            'servicetype': serviceType,
                            'TaskID': widget.taskID
                          });
                        },
                        child: Text(
                          translation(context)!.homeOwnerProjectTasksAddProvider,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
