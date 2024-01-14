import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Tasks/taskWidgets/sp_catalogDialog.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';

void main() {
  runApp(GetMaterialApp(home: WindowInstallationSP()));
}

class WindowInstallationSP extends StatefulWidget {
  const WindowInstallationSP({super.key});

  @override
  State<WindowInstallationSP> createState() => _WindowInstallationSPState();
}

class _WindowInstallationSPState extends State<WindowInstallationSP> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> windowData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      windowData = arguments['task13Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (windowData['Notes'] != null) {
        _userNotes.text = windowData['Notes'];
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

  Future<void> openCatalog(String itemID) async {
    Map<String, dynamic> itemDetails = {};
    if (itemID != null) {
      itemDetails = await CatalogAPI.getItemDetails(itemID);
    } else {
      Get.snackbar("Alert Message",
          "Owner of the project didn't choose an item yet... ");
    }

    await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return CatalogDialogSP(
          itemDetails: itemDetails,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed('/HomePage/ServiceProvider') ;
        return true ;
      },
      child: Scaffold(
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
                  taskID: windowData['TaskID'] ?? 0,
                  taskName: 'Aluminum Work',
                  projectName: windowData['ProjectName'] ?? 'Unknown',
                  taskStatus: windowData['TaskStatus'] ?? 'Unknown',
                ),
                TaskProviderInformation(
                  userPicture: windowData['UserPicture'],
                  rating: (windowData['Rating'] as num?)?.toDouble() ?? 0.0,
                  numOfReviews: windowData['ReviewCount'] ?? 0,
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
                              "Home Owner Needs",
                              style: TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*
                              here we should check if the home owner didn't choose one of the following (bedroom ,
                              bathroom, .. etc), then we should print a text called N/A (which indicates the user didn't
                              chose anything, and the text will be put instead of the container (See details).
                               */
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "Window Design:",
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await openCatalog(
                                          windowData['WindowDesign'].toString());
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, right: 8),
                                            child: Icon(
                                              Icons.file_open,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              "See Details",
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
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          padding: EdgeInsets.only(bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: 5, left: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Your Notes: ",
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: TextFormField(
                                        maxLines: 5,
                                        minLines: 5,
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
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2F4771),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
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
                                        if (isSubmitVisible)
                                          Expanded(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF2F4771),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30.0)),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Colors.white,
                                                          title: const Text(
                                                              "Complete Task"),
                                                          content: const Text(
                                                              "By clicking OK, you will mark the task as complete."),
                                                          actions: [
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFF3D69B), // Set background color to yellow
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if (areFieldsValid(
                                                                    _userNotes
                                                                        .text)) {
                                                                  String message =
                                                                      await ServiceProviderGetTasksAPI
                                                                          .setTask6Data(
                                                                    taskID,
                                                                    _userNotes
                                                                        .text,
                                                                    'Submit',
                                                                    taskProjectId,
                                                                  );
                                                                  setState(() {
                                                                    windowData[
                                                                            'TaskStatus'] =
                                                                        'Completed';
                                                                    isSubmitVisible =
                                                                        false;
                                                                  });
                                                                  Navigator.pop(
                                                                      context); // Close the dialog
                                                                } else {
                                                                  CustomAlertDialog
                                                                      .showErrorDialog(
                                                                          context,
                                                                          'Please fill in all the required fields.');
                                                                  Navigator.pop(
                                                                      context); // Close the dialog
                                                                }
                                                              },
                                                              child: const Text(
                                                                "OK",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF2F4771),
                                                                    fontSize: 15),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFF3D69B), // Set background color to yellow
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Close the dialog
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF2F4771),
                                                                    fontSize: 15),
                                                              ),
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
                                                )),
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
      ),
    );
  }
}
