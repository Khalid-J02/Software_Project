import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../taskWidgets/landInformation.dart';
import 'widgets/taskerProfile.dart';
import 'widgets/textFieldTasks.dart';

void main() {
  runApp(GetMaterialApp(home: SpPropertySurvey()));
}

class SpPropertySurvey extends StatefulWidget {
  const SpPropertySurvey({super.key});

  @override
  State<SpPropertySurvey> createState() => _SpPropertySurveyState();
}

class _SpPropertySurveyState extends State<SpPropertySurvey> {
  final _landArea = TextEditingController();
  final _userNotes = TextEditingController();

  Map<String, dynamic> propertySurveyData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      propertySurveyData = arguments['task1Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      // Display Data
      if (propertySurveyData['PropertySize'] != null) {
        _landArea.text = propertySurveyData['PropertySize'];
        isSubmitVisible = false;
      } else {
        _landArea.text = '';
      }
      if (propertySurveyData['Notes'] != null) {
        _userNotes.text = propertySurveyData['Notes'];
      } else {
        _userNotes.text = '';
      }
    });
    // fetchArgumentsAndData();
  }

  bool areFieldsValid(
      String landArea, String surveyDocumentValue, String userNotes) {
    if (landArea.isNotEmpty &&
        surveyDocumentValue.isNotEmpty &&
        userNotes.isNotEmpty) {
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
                taskID: propertySurveyData['TaskID'] ?? 0,
                taskName: propertySurveyData['TaskName'] ?? 'Unknown',
                projectName: propertySurveyData['ProjectName'] ?? 'Unknown',
                taskStatus: propertySurveyData['TaskStatus'] ?? 'Unknown',
              ),
              LandInformation(
                basinNumber: propertySurveyData['BasinNumber'] ?? 'Unknown',
                plotNumber: propertySurveyData['PlotNumber'] ?? 'Unknown',
              ),
              TaskProviderInformation(
                userPicture: propertySurveyData['UserPicture'],
                rating:
                    (propertySurveyData['Rating'] as num?)?.toDouble() ?? 0.0,
                numOfReviews: propertySurveyData['ReviewCount'] ?? 0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height / 2,
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
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.landscape_outlined,
                                    color: Color(0xFF2F4771),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Land Area: ",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextfieldTasks(
                                  controller: _landArea,
                                  hintText: 'Enter Land Area Here',
                                  labelText: 'Land Area',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Survey Document: ",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
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
                                            _landArea.text,
                                            "survey_document_value",
                                            _userNotes.text)) {
                                          String message =
                                              await ServiceProviderGetTasksAPI
                                                  .setTask1Data(
                                            taskID,
                                            taskProjectId,
                                            _landArea.text,
                                            'survey_document_value',
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
