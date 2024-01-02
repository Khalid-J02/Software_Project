import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../taskWidgets/Information.dart';
import '../../taskWidgets/taskInformation.dart';
import '../../taskWidgets/taskProviderInformation.dart';

void main() {
  runApp(const GetMaterialApp(home: LocalGovernoratePermitsSP()));
}

class LocalGovernoratePermitsSP extends StatefulWidget {
  const LocalGovernoratePermitsSP({super.key});

  @override
  State<LocalGovernoratePermitsSP> createState() =>
      _LocalGovernoratePermitsSPState();
}

class _LocalGovernoratePermitsSPState extends State<LocalGovernoratePermitsSP> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> regulatoryInformationData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      regulatoryInformationData = arguments['task2Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (regulatoryInformationData['Notes'] != null) {
        _userNotes.text = regulatoryInformationData['Notes'];
        isSubmitVisible = false;
      } else {
        _userNotes.text = '';
      }

    });
  }

  bool areFieldsValid( String permitsDocumentValue, String userNotes) {
    if (permitsDocumentValue.isNotEmpty && userNotes.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF3D69B),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 5),
          child: const Text(
            "Task Details",
            style: TextStyle(color: Color(0xFFF3D69B)),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TaskInformation(
                taskID: regulatoryInformationData['TaskID'] ?? 0,
                taskName: regulatoryInformationData['TaskName'] ?? 'Unknown',
                projectName: regulatoryInformationData['ProjectName'] ?? 'Unknown',
                taskStatus: regulatoryInformationData['TaskStatus'] ?? 'Unknown',
              ),
              Information(
                title: 'Required Documents for This Task', documentName: 'Survey Document:', document: regulatoryInformationData['SurveyDocument'],
              ),
              TaskProviderInformation(
                userPicture: regulatoryInformationData['UserPicture'],
                rating:
                    (regulatoryInformationData['Rating'] as num?)?.toDouble() ?? 0.0,
                numOfReviews: regulatoryInformationData['ReviewCount'] ?? 0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height / 2.56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 17,
                      // color: Color(0xFF6781A6),
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
                          "Task Details",
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       const Padding(
                          //         padding: EdgeInsets.all(10),
                          //         child: Text(
                          //           "Survey Document: ",
                          //           style: TextStyle(
                          //               color: Color(0xFF2F4771),
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.w400
                          //           ),
                          //         ),
                          //       ),
                          //       Row(
                          //         children: [
                          //           Container(
                          //             margin: const EdgeInsets.only(top: 5 , right: 5),
                          //             height: 35,
                          //             width: 80,
                          //             decoration: BoxDecoration(
                          //               color: Color(0xFF2F4771),
                          //               borderRadius: BorderRadius.circular(20.0),
                          //             ),
                          //             child: const Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 8.0 , left: 8 , bottom: 8 , right: 4),
                          //                   child: Icon(
                          //                     Icons.file_open_outlined,
                          //                     size: 20,
                          //                     color: Color(0xFFF9FAFB),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Open",
                          //                   style: TextStyle(
                          //                       color: Color(0xFFF9FAFB),
                          //                       fontWeight: FontWeight.w400,
                          //                       fontSize: 14
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: const EdgeInsets.only(top: 5),
                          //             height: 35,
                          //             width: 100,
                          //             decoration: BoxDecoration(
                          //               color: Color(0xFF2F4771),
                          //               borderRadius: BorderRadius.circular(20.0),
                          //             ),
                          //             child: const Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 8.0 , left: 8 , bottom: 8 , right: 4),
                          //                   child: Icon(
                          //                     Icons.sim_card_download_outlined,
                          //                     size: 20,
                          //                     color: Color(0xFFF9FAFB),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Download",
                          //                   style: TextStyle(
                          //                     color: Color(0xFFF9FAFB),
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 14
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       const Padding(
                          //         padding: EdgeInsets.all(10),
                          //         child: Text(
                          //           "Land Ownership Document: ",
                          //           style: TextStyle(
                          //               color: Color(0xFF2F4771),
                          //               fontSize: 16,
                          //               fontWeight: FontWeight.w400
                          //           ),
                          //         ),
                          //       ),
                          //       Column(
                          //         children: [
                          //           Container(
                          //             margin: const EdgeInsets.only(top: 5 , right: 15),
                          //             height: 35,
                          //             width: 85,
                          //             decoration: BoxDecoration(
                          //               color: Color(0xFF2F4771),
                          //               borderRadius: BorderRadius.circular(20.0),
                          //             ),
                          //             child: const Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 8.0 , left: 8 , bottom: 8 , right: 8),
                          //                   child: Icon(
                          //                     Icons.file_open_outlined,
                          //                     size: 20,
                          //                     color: Color(0xFFF9FAFB),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Open",
                          //                   style: TextStyle(
                          //                       color: Color(0xFFF9FAFB),
                          //                       fontWeight: FontWeight.w400,
                          //                       fontSize: 14
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Container(
                          //             margin: const EdgeInsets.only(top: 5 , right: 10),
                          //             height: 35,
                          //             width: 100,
                          //             decoration: BoxDecoration(
                          //               color: Color(0xFF2F4771),
                          //               borderRadius: BorderRadius.circular(20.0),
                          //             ),
                          //             child: const Row(
                          //               children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.only(top: 8.0 , left: 8 , bottom: 8 , right: 4),
                          //                   child: Icon(
                          //                     Icons.sim_card_download_outlined,
                          //                     size: 20,
                          //                     color: Color(0xFFF9FAFB),
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   "Download",
                          //                   style: TextStyle(
                          //                       color: Color(0xFFF9FAFB),
                          //                       fontWeight: FontWeight.w400,
                          //                       fontSize: 14
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Regulatory Info Doc:",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5 , right: 4),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F4771),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4, right: 4),
                                        child: Icon(
                                          Icons.upload_file_outlined,
                                          size: 20,
                                          color: Color(0xFFF9FAFB),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          "Upload",
                                          style: TextStyle(
                                            color: Color(0xFFF9FAFB),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5 , right: 5),
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2F4771),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8 , right: 8),
                                        child: Icon(
                                          Icons.delete_outline_outlined,
                                          size: 20,
                                          color: Color(0xFFF9FAFB),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Color(0xFFF9FAFB),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Your Notes: ",
                              style: TextStyle(
                                  color: Color(0xFF2F4771),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            height: 140,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              minLines: 4,
                              controller: _userNotes,
                              style: TextStyle(color: Color(0xFF2F4771)),
                              decoration: InputDecoration(
                                hintText: "Enter Notes here if any",
                                hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                filled: true,
                                fillColor: Color(0xFFF9FAFB),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F4771),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F4771),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 250,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2F4771),
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: isSubmitVisible
                                  ? TextButton(
                                onPressed: () async {
                                  if (areFieldsValid(
                                      "permits_document_value",
                                      _userNotes.text)) {
                                    String message =
                                    await ServiceProviderGetTasksAPI
                                        .setTask2Data(
                                      taskID,
                                      taskProjectId,
                                      'permits_document_value',
                                      _userNotes.text,
                                    );
                                    CustomAlertDialog.showSuccessDialog(
                                        context, message);

                                    // After successful submission, hide the button
                                    setState(() {
                                      isSubmitVisible = false;
                                    });
                                    return;
                                  } else {
                                    CustomAlertDialog.showErrorDialog(
                                        context,
                                        'Please fill in all the required fields.');
                                  }
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFF9FAFB),
                                  ),
                                ),
                              )
                                  : Container(),
                            ),
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
    );
  }
}
