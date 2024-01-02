import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/ServiceProviderGetTasksAPI.dart';

class SPTasksDetails extends StatelessWidget {
  final String taskProjectName ;
  final String taskProjectOwner ;
  final String taskProjectId ;

  final String taskStatus ;
  final String taskID ;
  final String taskNumber ;

  const SPTasksDetails(
      {
        super.key,
        required this.taskProjectName,
        required this.taskProjectOwner,
        required this.taskProjectId,
        required this.taskStatus,
        required this.taskID,
        required this.taskNumber,
      }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15 , right: 15 , top: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 10 , left: 15, right: 10),
        decoration: BoxDecoration(
            color: const  Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Color(0xFFF3D69B)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(taskProjectName ,
              style: const TextStyle(
                  fontSize: 22,
                  color: Color(0xFFF3D69B)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    color: Color(0xFFF9FAFB),
                    size: 20,
                  ),
                  Text(" $taskProjectOwner",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF9FAFB)
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Color(0xFFF9FAFB),
                    size: 20,
                  ),
                  Text(" $taskStatus",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF9FAFB)
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 170,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3D69B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 5 , top: 5),
                  child: TextButton(
                    onPressed: () async {
                        String path = '/ServiceProviderTasks/Task' + taskNumber;

                        if(taskNumber == '1'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask1Data(taskID);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task1Data' : data
                             });
                        }

                        if(taskNumber == '2'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask2Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task2Data' : data
                              });
                        }

                        if(taskNumber == '3'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask3Data(taskID);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task3Data' : data
                              });
                        }

                        if(taskNumber == '4'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask4Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task4Data' : data
                              });
                        }

                        if(taskNumber == '5'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask5Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task5Data' : data
                              });
                        }

                        if(taskNumber == '6'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task6Data' : data
                              });
                        }

                        if(taskNumber == '7'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task7Data' : data
                              });
                        }
                        if(taskNumber == '8'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task8Data' : data
                              });
                        }

                        if(taskNumber == '9'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task9Data' : data
                              });
                        }

                        if(taskNumber == '10'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task10Data' : data
                              });
                        }

                        if(taskNumber == '11'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task11Data' : data
                              });
                        }
                        if(taskNumber == '12'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task12Data' : data
                              });
                        }

                        if(taskNumber == '13'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task13Data' : data
                              });
                        }

                        if(taskNumber == '14'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task14Data' : data
                              });
                        }

                        if(taskNumber == '15'){
                          final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(taskID,taskProjectId);
                          Get.toNamed(path,
                              arguments: {
                                'taskID': taskID,
                                'taskProjectId': taskProjectId ,
                                'task15Data' : data
                              });
                        }
                    },

                    child: Text("Open Task ", //$taskID , $taskNumber
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF122247)
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
