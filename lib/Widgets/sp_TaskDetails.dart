import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/ServiceProviderGetTasksAPI.dart';

class SPTasksDetails extends StatefulWidget {
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
  State<SPTasksDetails> createState() => _SPTasksDetailsState();
}

class _SPTasksDetailsState extends State<SPTasksDetails> {

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
    final borderColor = getBorderColorBasedOnStatus(widget.taskStatus);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      child: Container(
        padding: const EdgeInsets.only(top: 10 , left: 15, right: 10),
        decoration: BoxDecoration(
            color: const  Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.taskProjectName ,
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
                  SizedBox(width: 4,),
                  Text(widget.taskProjectOwner,
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
                   Icon(
                    Icons.info,
                     color: getBorderColorBasedOnStatus(widget.taskStatus),
                     //color: Color(0xFFF9FAFB),

                    size: 20,
                  ),
                  SizedBox(width: 4,),
                  Text(widget.taskStatus,
                    style:  TextStyle(
                        fontSize: 14,
                      color: getBorderColorBasedOnStatus(widget.taskStatus),
                      //color: Color(0xFFF9FAFB)
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
                  width: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3D69B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 5 , top: 5),
                  child: TextButton(
                    onPressed: () async {
                      String path = '/ServiceProviderTasks/Task' + widget.taskNumber;

                      if(widget.taskNumber == '1'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask1Data(widget.taskID);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task1Data' : data
                            });
                      }

                      if(widget.taskNumber == '2'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask2Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task2Data' : data
                            });
                      }

                      if(widget.taskNumber == '3'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask3Data(widget.taskID);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task3Data' : data
                            });
                      }

                      if(widget.taskNumber == '4'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask4Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task4Data' : data
                            });
                      }

                      if(widget.taskNumber == '5'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask5Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task5Data' : data
                            });
                      }

                      if(widget.taskNumber == '6'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task6Data' : data
                            });
                      }

                      if(widget.taskNumber == '7'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task7Data' : data
                            });
                      }

                      if(widget.taskNumber == '8'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task8Data' : data
                            });
                      }

                      if(widget.taskNumber == '9'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task9Data' : data
                            });
                      }

                      if(widget.taskNumber == '10'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task10Data' : data
                            });
                      }

                      if(widget.taskNumber == '11'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task11Data' : data
                            });
                      }

                      if(widget.taskNumber == '12'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task12Data' : data
                            });
                      }

                      if(widget.taskNumber == '13'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task13Data' : data
                            });
                      }

                      if(widget.taskNumber == '14'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task14Data' : data
                            });
                      }

                      if(widget.taskNumber == '15'){
                        final Map<String, dynamic> data = await ServiceProviderGetTasksAPI.getTask6Data(widget.taskID,widget.taskProjectId);
                        Get.offNamed(path,
                            arguments: {
                              'taskID': widget.taskID,
                              'taskProjectId': widget.taskProjectId ,
                              'task15Data' : data
                            });
                      }
                    },

                    child: const Text("Open Task ", //$taskID , $taskNumber
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

