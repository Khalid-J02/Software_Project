import 'package:buildnex/screens/searchPage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/NavbarProjectPageHomeOwnerAPI.dart';
import '../APIRequests/homeOwnerTasksAPI.dart';
import 'customAlertDialog.dart';

class ProjectTasks extends StatelessWidget {
  final String taskProjectId;
  final String taskID;
  final String taskName;
  final String taskStatus;
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

  late String serviceType;
  late String projectEntryPoint;

  Color getBorderColorBasedOnStatus(String status) {
    if (status == 'Not Started') {
      return const Color(0xFFB22D00);
    } else if (status == 'In Progress') {
      return const Color(0xFFFF9637);
    } else  {
      return const Color(0xFF2BD066);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = getBorderColorBasedOnStatus(taskStatus);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF6781A6),
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: Color(0xFFF3D69B),
          // ),
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
                    taskName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF3D69B),
                    ),
                  ),
                ),
                 Expanded(
                  flex: 1,
                  child: Tooltip(
                    message: taskDescription ,
                    padding: const EdgeInsets.all(12),
                    showDuration: const Duration(seconds: 10),
                    textStyle: const TextStyle(color: Colors.white),
                    decoration: const BoxDecoration(
                      color: Color(0xFF122247)
                    ),
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
                    color: getBorderColorBasedOnStatus(taskStatus),
                   // color: Color(0xFFF9FAFB),
                    size: 18,
                  ),
                  Text(
                    " $taskStatus",
                    style:  TextStyle(
                      fontSize: 14,
                      color: getBorderColorBasedOnStatus(taskStatus),
                      //color: Color(0xFFF9FAFB),
                    ),
                  ),
                ],
              ),
            ),
            if (serviceProviderID != 'No Provider ID')
              Container(
                height: 48,
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
                          " $serviceProviderName",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFF9FAFB),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3D69B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: TextButton(
                        onPressed: () async {
                          // here you will move to tasks like task1 2 3 etc
                          final Map<String, dynamic> ProjectInfo = await HomeOwnerTasksAPI.getProjectInfoData( int.parse(taskProjectId));

                          String path = '/HomeOwnerTasks/Task' + taskNumber;
                          // print(taskNumber) ;
                          if(taskNumber == '1'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getPropertySurvey(taskID);
                            final String _docsURL = await HomeOwnerTasksAPI.getSurveyDocument(taskProjectId) ;
                            Get.toNamed(path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'propertySurveyData' : data,
                                  'docsURL' : _docsURL});
                          }
                          if(taskNumber == '2'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getPermitsRegulatoryInfo(taskID);
                            final String _docsURL = await HomeOwnerTasksAPI.getPermitsDocument(taskProjectId) ;
                            Get.toNamed(path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'localGovernmentData' : data,
                                  'docsURL' : _docsURL});
                          }
                          if(taskNumber == '3'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getSoilInvestigation(taskID);
                            final String _docsURL = await HomeOwnerTasksAPI.getSoilDocument(taskProjectId) ;
                            Get.toNamed(path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'soilTesting' : data,
                                  'docsURL' : _docsURL});
                          }
                          if(taskNumber == '4'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getDesignAndPlanning(taskID) ;
                            Get.toNamed(
                              path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'DesignData' : data,
                                'buildingData' : ProjectInfo,
                                }
                            );
                          }
                          if(taskNumber == '5'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getApprovals(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'GovernmentData' : data,
                                }
                            );
                          }
                          if(taskNumber == '6'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'taskData' : data,
                                  'projectData' : ProjectInfo
                                }
                            );
                          }
                          if(taskNumber == '7'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'datatask7' : data,
                                }
                            );
                          }
                          if(taskNumber == '8'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task8data' : data,
                                }
                            );
                          }
                          if(taskNumber == '9'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task9data' : data,
                                }
                            );
                          }
                          if(taskNumber == '10'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task10data' : data,
                                  'ProjectInfo' : ProjectInfo
                                }
                            );
                          }
                          if(taskNumber == '11'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task11data' : data,
                                }
                            );
                          }
                          if(taskNumber == '12'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task12data' : data,
                                  'projectInfo' : ProjectInfo
                                }
                            );
                          }
                          if(taskNumber == '13'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task13data' : data,
                                  'projectInfo' : ProjectInfo
                                }
                            );
                          }
                          if(taskNumber == '14'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task14data' : data,
                                  'projectInfo' : ProjectInfo
                                }
                            );
                          }
                          if(taskNumber == '15'){
                            final Map<String, dynamic> data = await HomeOwnerTasksAPI.getTask6(taskID) ;
                            Get.toNamed(
                                path,
                                arguments: {
                                  'taskID': taskID,
                                  'taskProjectId': taskProjectId ,
                                  'task15data' : data,
                                  'projectInfo' : ProjectInfo
                                }
                            );
                          }
                        },
                        child: const Text(
                          "Open Task",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
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
                      onPressed: () async  {
                        String previousTaskStatus;
                        final Map<String, dynamic> projectInfo = await HomeOwnerProjectPageNavbarAPI.getProjectData(taskProjectId);
                        if (projectInfo['ProjectEntryPoint'] == 'From Scratch') {
                          if(int.parse(taskNumber) > 1) {
                            previousTaskStatus = await HomeOwnerTasksAPI
                                .checkPreviousTaskStatus(int.parse(taskProjectId),
                                int.parse(taskNumber));

                            // Check the status of the previous task
                            if ((int.parse(taskNumber) >= 7 && int.parse(taskNumber) <= 9) )
                            {
                              previousTaskStatus = await HomeOwnerTasksAPI
                                  .checkPreviousTaskStatus(int.parse(taskProjectId),
                                  int.parse("7"));

                              await CustomAlertDialog.showParallelTasksDialog(context);

                            }
                            if (int.parse(taskNumber) == 10 ){
                              previousTaskStatus = await HomeOwnerTasksAPI
                                  .checkPreviousTaskStatus(int.parse(taskProjectId),
                                  int.parse("9"));
                            }

                            if (previousTaskStatus == "In Progress" ||
                                previousTaskStatus == "Not Started") {
                              CustomAlertDialog.showErrorDialog(
                                  context,
                                  'You can not go to the next task before complete previous one.');
                              return;
                            }
                          }
                        }
                        else if (projectInfo['ProjectEntryPoint'] == 'From Middle') {
                          if(int.parse(taskNumber) > 10) {
                              previousTaskStatus = await HomeOwnerTasksAPI
                                  .checkPreviousTaskStatus(int.parse(taskProjectId),
                                  int.parse(taskNumber));

                              if (previousTaskStatus == "In Progress" ||
                                  previousTaskStatus == "Not Started") {
                                CustomAlertDialog.showErrorDialog(
                                    context,
                                    'You can not go to the next task before complete previous one.');
                                return;
                              }
                            }

                        }

                        if (int.parse(taskNumber) == 16) {
                          CustomAlertDialog.showErrorDialogForTask16(
                              context,
                              taskDescription);
                          return;                        }

                        if (int.parse(taskNumber) == 1) {
                            serviceType = "Surveyor";
                          }
                          else if (int.parse(taskNumber) >= 2 && int.parse(
                              taskNumber) <= 5) {
                            serviceType = "Engineering Office";
                          }
                          else if (int.parse(taskNumber) == 6) {
                            serviceType = "Constructor";
                          }
                          else if (int.parse(taskNumber) == 7) {
                            serviceType = "Plumbing Technician";
                          }
                          else if (int.parse(taskNumber) == 8) {
                            serviceType = "Electrical Technician";
                          }
                          else if (int.parse(taskNumber) == 9) {
                            serviceType = "Insulation Technician";
                          }
                          else if (int.parse(taskNumber) == 10) {
                            serviceType = "Carpenter";
                          }
                          else if (int.parse(taskNumber) == 11) {
                            serviceType = "Plasterer";
                          }
                          else if (int.parse(taskNumber) == 12) {
                            serviceType = "Tile Contractor";
                          }
                          else if (int.parse(taskNumber) == 13) {
                            serviceType = "Window Installer";
                          }
                          else if (int.parse(taskNumber) == 14) {
                            serviceType = "Carpenter";
                          }
                          else if (int.parse(taskNumber) == 15) {
                            serviceType = "Painter";
                          }
                          // Navigate to the next screen and pass taskID and serviceProviderID
                          Get.to(SearchPage(askForRequest: true), arguments: {'servicetype' : serviceType , 'TaskID' : taskID} );
                      },

                      child: const Text(
                        "Add Provider",
                        style: TextStyle(
                          fontSize: 17,
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
    );
  }
}
