import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../taskWidgets/Information.dart';


void main() {
  runApp(GetMaterialApp(home: ElectricalInstallSP()));
}

class ElectricalInstallSP extends StatefulWidget {
  const ElectricalInstallSP({super.key});

  @override
  State<ElectricalInstallSP> createState() => _ElectricalInstallSPState();
}

class _ElectricalInstallSPState extends State<ElectricalInstallSP> {

  //final _electricPricePerUnit = TextEditingController() ;
  final _userNotes = TextEditingController();

  Map<String, dynamic> electricalData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      electricalData = arguments['task8Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      //print(electricalData);
      if (electricalData['Notes'] != null) {
        _userNotes.text = electricalData['Notes'];
        isSubmitVisible = false;
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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/5),
          child: const Text(
            "Task Details",
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
                taskID: electricalData['TaskID'] ?? 0,
                taskName: electricalData['TaskName'] ?? 'Unknown',
                projectName: electricalData['ProjectName'] ?? 'Unknown',
                taskStatus: electricalData['TaskStatus'] ?? 'Unknown',
              ),
              Information(
                title: 'Required Documents for This Task',
                documentName: 'Electrical Document:',
                document: electricalData['ElectricalDocument'],
              ),
              TaskProviderInformation(
                userPicture: electricalData['UserPicture'],
                rating: (electricalData['Rating'] as num?)?.toDouble() ?? 0.0,
                numOfReviews: electricalData['ReviewCount'] ?? 0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
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
                        child: const Center(
                          child: Text(
                            "Task Details",
                            style: TextStyle(
                                color: Color(0xFFF9FAFB),
                                fontSize: 19,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Expanded(
                            //       flex: 1,
                            //       child: Padding(
                            //         padding: EdgeInsets.only(left: 8 ,right: 8),
                            //         child: Text(
                            //           "Electrical Document:",
                            //           style: TextStyle(
                            //               color: Color(0xFF2F4771),
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 16
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       margin: const EdgeInsets.only(top: 5 , right: 5),
                            //       height: 35,
                            //       decoration: BoxDecoration(
                            //         color: const Color(0xFF2F4771),
                            //         borderRadius: BorderRadius.circular(20.0),
                            //       ),
                            //       child: const Row(
                            //         children: [
                            //           Padding(
                            //             padding: EdgeInsets.only(left: 8 , right: 8),
                            //             child: Icon(
                            //               Icons.sim_card_download,
                            //               size: 20,
                            //               color: Color(0xFFF9FAFB),
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding: EdgeInsets.only(right: 12.0),
                            //             child: Text(
                            //               "Download",
                            //               style: TextStyle(
                            //                 color: Color(0xFFF9FAFB),
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.w400,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Container(
                            //       margin: const EdgeInsets.only(top: 5 , right: 5),
                            //       height: 35,
                            //       decoration: BoxDecoration(
                            //         color: const Color(0xFF2F4771),
                            //         borderRadius: BorderRadius.circular(20.0),
                            //       ),
                            //       child: const Row(
                            //         children: [
                            //           Padding(
                            //             padding: EdgeInsets.only(left: 8 , right: 8),
                            //             child: Icon(
                            //               Icons.file_open_outlined,
                            //               size: 20,
                            //               color: Color(0xFFF9FAFB),
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding: EdgeInsets.only(right: 12.0),
                            //             child: Text(
                            //               "Open",
                            //               style: TextStyle(
                            //                 color: Color(0xFFF9FAFB),
                            //                 fontSize: 15,
                            //                 fontWeight: FontWeight.w400,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Expanded(
                            //       flex: 1,
                            //       child: Padding(
                            //         padding: EdgeInsets.only(left: 8),
                            //         child: Text(
                            //           "Price / Unit:  (JOD)",
                            //           style: TextStyle(
                            //               color: Color(0xFF2F4771),
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 16
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 1,
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(horizontal: 0),
                            //         child: TextfieldTasks(controller: _electricPricePerUnit, hintText: 'Enter Your Price', labelText: 'Price/Unit',),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 10,
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                maxLines: null,
                                minLines: 4,
                                controller: _userNotes,
                                style: TextStyle(color: Color(0xFF2F4771)),
                                decoration: InputDecoration(
                                  hintText: "Enter Notes here if any",
                                  hintStyle:
                                  TextStyle(color: Color(0xFF2F4771)),
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
                                    if (areFieldsValid(_userNotes.text)) {
                                      String message =
                                      await ServiceProviderGetTasksAPI
                                          .setTask6Data(
                                        taskID,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
