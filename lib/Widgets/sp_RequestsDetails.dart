import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../APIRequests/serviceProviderRequestsAPI.dart';
import '../classes/language_constants.dart';
import '../screens/projectDetails_SP.dart';
import 'customAlertDialog.dart';

class SPRequestDetails extends StatelessWidget {
  final String taskProjectName;
  final String taskHomeOwnerName;
  final String taskProjectId;
  final String taskHomeOwnerId;
  final String taskId;
  final String taskNumber;
  final String requestId;
  final Function(String name) removeProject;

  const SPRequestDetails({
    super.key,
    required this.taskProjectName,
    required this.taskHomeOwnerName,
    required this.taskProjectId,
    required this.taskHomeOwnerId,
    required this.taskId,
    required this.taskNumber,
    required this.requestId,
    required this.removeProject,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
          decoration: BoxDecoration(
              color: const Color(0xFF6781A6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFF3D69B))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                taskProjectName,
                style: const TextStyle(fontSize: 22, color: Color(0xFFF3D69B)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.task,
                      color: Color(0xFFF9FAFB),
                      size: 20,
                    ),
                    Text(
                      " $taskHomeOwnerName",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFF9FAFB)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      onPressed: () {
                        Get.to(ProjectDetailsSP(), arguments: {
                          'projectId': taskProjectId,
                          'taskId': taskId,
                          'taskNumber': taskNumber,
                          'HomeOwnerId': taskHomeOwnerId
                        });
                      },
                      child:  Text(
                        translation(context)!.sp_RequestDetails_ButtonText,
                        style:
                            const TextStyle(fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF122247)),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              bool result = await CustomAlertDialog
                                  .showConfirmationDialog(context);
                              if (result) {
                                await RequestsAPI.acceptRequest(requestId);
                                removeProject(taskProjectName);
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2F4771),
                              minimumSize:
                                  Size(50, 35), // Change width and height
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Change circular border radius
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 25,
                              color: Color(0xFFF3D69B),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                            onPressed: () async {
                              final declineReason = await CustomAlertDialog
                                  .showDeclineReasonDialog(context);
                              if (declineReason != null) {
                                await RequestsAPI.declineRequest(
                                    requestId, declineReason);
                                removeProject(taskProjectName);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2F4771),
                              minimumSize:
                                  Size(50, 35), // Change width and height
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Change circular border radius
                              ),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 25,
                              color: Color(0xFFF3D69B),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
