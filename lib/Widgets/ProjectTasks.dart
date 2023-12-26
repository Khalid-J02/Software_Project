import 'package:buildnex/screens/searchPage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF6781A6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFF3D69B),
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
                  /*
                  Here you should pass the description for the task, to test it you should
                  keep pressing the info icon in the top right
                   */
                  flex: 1,
                  child: Tooltip(
                    message: taskDescription ,
                    padding: EdgeInsets.all(12),
                    showDuration: Duration(seconds: 10),
                    textStyle: TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                      color: Color(0xFF122247)
                    ),
                    preferBelow: false,
                    verticalOffset: 10,
                    child: Icon(
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
                  const Icon(
                    Icons.info,
                    color: Color(0xFFF9FAFB),
                    size: 18,
                  ),
                  Text(
                    " $taskStatus",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFF9FAFB),
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
                        onPressed: () {
                          // here you will move to tasks like task1 2 3 etc
                          String path = '/HomeOwnerTasks/Task' + taskNumber;
                          Get.toNamed(path, arguments: {'taskID': taskID, 'taskProjectId': taskProjectId});
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
                        if(int.parse(taskNumber) > 1)
                        {
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

                               if (previousTaskStatus == "In Progress" ||
                                  previousTaskStatus == "Not Started") {
                                CustomAlertDialog.showErrorDialog(
                                    context,
                                    'You can not go to the next task while current task in progress');
                                return;
                              }
                          }

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
                            serviceType = "Insulation & HVAC Contractors";
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
                          Get.to(SearchPage(askForRequest: true),
                              arguments: serviceType);
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
