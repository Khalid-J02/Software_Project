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
  runApp(GetMaterialApp(home: InsulationInstallSP()));
}

class InsulationInstallSP extends StatefulWidget {
  const InsulationInstallSP({super.key});

  @override
  State<InsulationInstallSP> createState() => _InsulationInstallSPState();
}

class _InsulationInstallSPState extends State<InsulationInstallSP> {
  // final _InsulationPricePerUnit = TextEditingController() ;
  final _userNotes = TextEditingController();
  Map<String, dynamic> hvacData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      hvacData = arguments['task9Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      //print(hvacData);
      if (hvacData['Notes'] != null) {
        _userNotes.text = hvacData['Notes'];
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TaskInformation(
                taskID: hvacData['TaskID'] ?? 0,
                taskName: hvacData['TaskName'] ?? 'Unknown',
                projectName: hvacData['ProjectName'] ?? 'Unknown',
                taskStatus: hvacData['TaskStatus'] ?? 'Unknown',
              ),
              Information(
                title: 'Required Documents for This Task',
                documentName: 'Insulation & HVAC Document:',
                document: hvacData['InsulationAndHVACDocument'],
              ),
              TaskProviderInformation(
                userPicture: hvacData['UserPicture'],
                rating: (hvacData['Rating'] as num?)?.toDouble() ?? 0.0,
                numOfReviews: hvacData['ReviewCount'] ?? 0,
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
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: null,
                                      minLines: 4,
                                      controller: _userNotes,
                                      style:
                                          TextStyle(color: Color(0xFF2F4771)),
                                      decoration: InputDecoration(
                                        hintText: "Enter Notes here if any",
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF2F4771),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(30.0)),
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
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFFF9FAFB),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(isSubmitVisible)
                                        Expanded(
                                          child: Container(
                                              margin: EdgeInsets.symmetric(horizontal: 8),
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF2F4771),
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(30.0)),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        title: const Text("Complete Task"),
                                                        content: const Text("By clicking OK, you will mark the task as complete."),
                                                        actions: [
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor: Color(0xFFF3D69B), // Set background color to yellow
                                                            ),
                                                            onPressed: () async {
                                                              if (areFieldsValid(_userNotes.text)) {
                                                                String message = await ServiceProviderGetTasksAPI.setTask6Data(
                                                                    taskID,
                                                                    _userNotes.text,
                                                                    'Submit',
                                                                  taskProjectId,
                                                                );
                                                                setState(() {
                                                                  hvacData['TaskStatus'] = 'Completed' ;
                                                                  isSubmitVisible = false ;
                                                                });
                                                                Navigator.pop(context); // Close the dialog
                                                              } else {
                                                                CustomAlertDialog.showErrorDialog(context, 'Please fill in all the required fields.');
                                                                Navigator.pop(context); // Close the dialog
                                                              }
                                                            },
                                                            child: const Text("OK" , style: TextStyle(
                                                                color: Color(0xFF2F4771),
                                                                fontSize: 15
                                                            ),),
                                                          ),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor: Color(0xFFF3D69B), // Set background color to yellow
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(context); // Close the dialog
                                                            },
                                                            child: const Text("Cancel" , style: TextStyle(
                                                                color: Color(0xFF2F4771),
                                                                fontSize: 15
                                                            ),),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                  'Mark as Done',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                              )
                                          ),
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
    );
  }
}
