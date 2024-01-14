import 'dart:convert';
import 'dart:io';

import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import 'package:http/http.dart' as http;

const cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
const uploadPreset = 'buildnex';

void main() {
  runApp(GetMaterialApp(home: SoilTestingSP()));
}

class SoilTestingSP extends StatefulWidget {
  const SoilTestingSP({super.key});

  @override
  State<SoilTestingSP> createState() => _SoilTestingSPState();
}

class _SoilTestingSPState extends State<SoilTestingSP> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> soilInvestigationsData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;
  String fileURL = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      soilInvestigationsData = arguments['task3Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (soilInvestigationsData['SoilDocument'] != null) {
        fileURL = soilInvestigationsData['SoilDocument'];
      } else {
        fileURL = '';
      }

      if (soilInvestigationsData['Notes'] != null) {
        _userNotes.text = soilInvestigationsData['Notes'];
        isSubmitVisible = false;
      } else {
        _userNotes.text = '';
      }
    });
  }

  bool areFieldsValid(String soilDocumentValue, String userNotes) {
    if (soilDocumentValue.isNotEmpty && userNotes.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<File>?>? pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      return result.files
          .map((platformFile) => File(platformFile.path!))
          .toList(); // Convert PlatformFile to File
    } else {
      return null;
    }
  }

  Future<void> uploadFileToCloudinaryNew() async {
    final files = await pickFiles();

    if (files != null && files.isNotEmpty) {
      final file = files[0];
      final url = Uri.parse('https://api.cloudinary.com/v1_1/df1qhofpr/upload');
      final req = http.MultipartRequest('POST', url);

      // Replace with your Cloudinary API key and API secret
      final yourApiKey = '963828481836588';
      final yourApiSecret = 'txthSPtmmjuu8KiEuBxXhBP-2kA';

      // Set authorization header
      final credentials =
          Base64Encoder().convert('$yourApiKey:$yourApiSecret'.codeUnits);
      req.headers['Authorization'] = 'Basic $credentials';

      // Add upload preset and file
      req.fields['upload_preset'] = uploadPreset;
      req.files.add(await http.MultipartFile.fromPath('file', file!.path));

      try {
        // Send the request
        final response = await req.send();

        if (response.statusCode == 200) {
          // Parse the response
          final responseData = await response.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);

          // Extract and print the uploaded file URL
          final uploadedFileUrl = jsonMap['secure_url'];
          // print("Uploaded file URL: $uploadedFileUrl");

          // Update UI with the uploaded file URL (optional)
          setState(() {
            fileURL = uploadedFileUrl;
            // Update your state with the uploaded file URL
          });
        } else {
          // Handle upload failure
          print("Error uploading file: ${response.statusCode}");
        }
      } catch (error) {
        // Handle any exceptions that may occur during the upload
        print("Error uploading file: $error");
      }
    }
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
                  taskID: soilInvestigationsData['TaskID'] ?? 0,
                  taskName: 'Soil Investigation',
                  projectName: soilInvestigationsData['ProjectName'] ?? 'Unknown',
                  taskStatus: soilInvestigationsData['TaskStatus'] ?? 'Unknown',
                ),
                TaskProviderInformation(
                  userPicture: soilInvestigationsData['UserPicture'],
                  rating:
                      (soilInvestigationsData['Rating'] as num?)?.toDouble() ??
                          0.0,
                  numOfReviews: soilInvestigationsData['ReviewCount'] ?? 0,
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
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 0,
                                          top: 14,
                                        ),
                                        child: Text(
                                          "Soil Invest Document: ",
                                          style: TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await uploadFileToCloudinaryNew();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, right: 3),
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2F4771),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 4),
                                              child: Icon(
                                                Icons.upload_file_outlined,
                                                size: 20,
                                                color: Color(0xFFF9FAFB),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
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
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (fileURL != null) {
                                          Get.to(DocsPdfViewer(
                                            pdfFileURL: fileURL,
                                          ));
                                        } else {
                                          Get.snackbar(
                                              'Hi', 'There is no file to open',
                                              colorText: Colors.white,
                                              backgroundColor: Color(0xFF2F4771));
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, right: 0),
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2F4771),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 6),
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                size: 20,
                                                color: Color(0xFFF9FAFB),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.0),
                                              child: Text(
                                                "Open",
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
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
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
                                                    .setTask3Data(
                                                  taskID,
                                                  taskProjectId,
                                                  fileURL,
                                                  _userNotes.text,
                                                  'Update Data',
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
                                                                    fileURL,
                                                                    _userNotes
                                                                        .text)) {
                                                                  String message =
                                                                      await ServiceProviderGetTasksAPI.setTask3Data(
                                                                          taskID,
                                                                          taskProjectId,
                                                                          fileURL,
                                                                          _userNotes
                                                                              .text,
                                                                          'Submit');
                                                                  setState(() {
                                                                    soilInvestigationsData[
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
