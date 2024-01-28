import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/ServiceProviderGetTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';
import '../../../classes/language_constants.dart';
import '../../taskWidgets/designAndPlanningInformation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

const cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
const uploadPreset = 'buildnex';

void main() {
  runApp(GetMaterialApp(home: DesignAndPlanningSP()));
}

class DesignAndPlanningSP extends StatefulWidget {
  const DesignAndPlanningSP({super.key});

  @override
  State<DesignAndPlanningSP> createState() => _DesignAndPlanningSPState();
}

class _DesignAndPlanningSPState extends State<DesignAndPlanningSP> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> designAndPlanningData = {};
  String taskID = '';
  String taskProjectId = '';

  bool isSubmitVisible = true;
  String designDocumentURL = '';
  String foundationDocumentURL = '';
  String plumbingDocumentURL = '';
  String electricalDocumentURL = '';
  String insulationAndHVACDocumentURL = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      designAndPlanningData = arguments['task4Data'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      if (designAndPlanningData['TaskStatus'] == 'Completed') {
        setState(() {
          isSubmitVisible = false;
        });
      }

      if (designAndPlanningData['DesignDocument'] != null) {
        designDocumentURL = designAndPlanningData['DesignDocument'];
      } else {
        designDocumentURL = '';
      }
      if (designAndPlanningData['FoundationDocument'] != null) {
        foundationDocumentURL = designAndPlanningData['FoundationDocument'];
      } else {
        foundationDocumentURL = '';
      }
      if (designAndPlanningData['PlumbingDocument'] != null) {
        plumbingDocumentURL = designAndPlanningData['PlumbingDocument'];
      } else {
        plumbingDocumentURL = '';
      }
      if (designAndPlanningData['ElectricalDocument'] != null) {
        electricalDocumentURL = designAndPlanningData['ElectricalDocument'];
      } else {
        electricalDocumentURL = '';
      }
      if (designAndPlanningData['InsulationAndHVACDocument'] != null) {
        insulationAndHVACDocumentURL =
            designAndPlanningData['InsulationAndHVACDocument'];
      } else {
        insulationAndHVACDocumentURL = '';
      }

      if (designAndPlanningData['Notes'] != null) {
        _userNotes.text = designAndPlanningData['Notes'];
      } else {
        _userNotes.text = '';
      }
    });
  }

  bool areFieldsValid(
      String designDocument,
      String foundationDocument,
      String plumbingDocument,
      String electricalDocument,
      String insulationAndHVACDocument,
      String userNotes) {
    if (designDocument.isNotEmpty &&
        foundationDocument.isNotEmpty &&
        plumbingDocument.isNotEmpty &&
        electricalDocument.isNotEmpty &&
        insulationAndHVACDocument.isNotEmpty &&
        userNotes.isNotEmpty) {
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

  Future<String?> uploadFileToCloudinaryNew() async {
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

          return uploadedFileUrl;
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

  String translateTaskStatus(String status, BuildContext context) {
    switch (status) {
      case 'Not Started':
        return translation(context)!.taskStatusNotStarted;
      case 'In Progress':
        return translation(context)!.taskStatusInProgress;
      case 'Completed':
        return translation(context)!.taskStatusCompleted;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = !(translation(context)!.localeName == 'ar');

    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: WillPopScope(
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
            child:  Text(
              translation(context)!.sp_taskTitle,
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
                  taskID: designAndPlanningData['TaskID'] ?? 0,
                  taskName: translation(context)!.sp_task4Name,
                  projectName: designAndPlanningData['ProjectName'] ?? 'Unknown',
                  taskStatus: translateTaskStatus(
                      designAndPlanningData['TaskStatus'], context),
                ),
                TaskProviderInformation(
                  userPicture: designAndPlanningData['UserPicture'],
                  rating: (designAndPlanningData['Rating'] as num?)?.toDouble() ??
                      0.0,
                  numOfReviews: designAndPlanningData['ReviewCount'] ?? 0,
                ),
                DesignAndPlanningInformation(
                  title: translation(context)!.task2_InformationTitle,
                  documentName1: translation(context)!.sp_task2Document,
                  document1: designAndPlanningData['PermitsDocument'] ?? '',
                  documentName2: translation(context)!.sp_task3Document_task4,
                  document2: designAndPlanningData['SoilDocument'] ?? '',
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
                          child:  Center(
                            child: Text(
                              translation(context)!.sp_task4Demands,
                              style: const TextStyle(
                                  color: Color(0xFFFFFFFF),
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
                              Row(
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4DemandsRooms,
                                        style:  TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500 :  FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                            color: Color(0xFF2F4771), width: 1.8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (designAndPlanningData['NumberOfRooms'] ?? translation(context)!.sp_task4Chosen).toString(),
                                          style:  const TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontWeight:  FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4DemandsFloors,
                                        style:  TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500 :  FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                            color: Color(0xFF2F4771), width: 1.8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (designAndPlanningData['NumberOfFloors']?? translation(context)!.sp_task4Chosen).toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4DemandsArea,
                                        style:  TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl? FontWeight.w500 :  FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9FAFB),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        border: Border.all(
                                            color: Color(0xFF2F4771), width: 1.8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (designAndPlanningData['BuildingArea']??translation(context)!.sp_task4Chosen).toString(),
                                          style: const TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                          child:  Center(
                            child: Text(
                                translation(context)!.sp_taskTitle,
                              style: const TextStyle(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 4,
                                      ),
                                      child: Text(
                                        translation(context)!.sp_task4Design,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl ? FontWeight.w500 : FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() async {
                                        designDocumentURL =
                                            (await uploadFileToCloudinaryNew())!;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.upload_file_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.upload,
                                              style: const TextStyle(
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
                                      if (designDocumentURL != '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: designDocumentURL,
                                        ));
                                      }  else {
                                        Get.snackbar(
                                          '',
                                          '',
                                          titleText: Text(
                                            translation(context)!.sp_task10snackbarTitle,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          messageText: Text(
                                            translation(context)!.snackbarContent,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFF2F4771),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.open,
                                              style: const TextStyle(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4Arch, // Foundation became Architectural
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl ? FontWeight.w500 : FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() async {
                                        foundationDocumentURL =
                                            (await uploadFileToCloudinaryNew())!;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.upload_file_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.upload,
                                              style: const TextStyle(
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
                                      if (foundationDocumentURL != '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: foundationDocumentURL,
                                        ));
                                      }  else {
                                        Get.snackbar(
                                          '',
                                          '',
                                          titleText: Text(
                                            translation(context)!.sp_task10snackbarTitle,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          messageText: Text(
                                            translation(context)!.snackbarContent,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFF2F4771),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.open,
                                              style: const TextStyle(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4Civil,//Insulation became Civil
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl ? FontWeight.w500 : FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() async {
                                        insulationAndHVACDocumentURL =
                                            (await uploadFileToCloudinaryNew())!;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.upload_file_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.upload,
                                              style: const TextStyle(
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
                                      if (insulationAndHVACDocumentURL != '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL:
                                              insulationAndHVACDocumentURL,
                                        ));
                                      }  else {
                                        Get.snackbar(
                                          '',
                                          '',
                                          titleText: Text(
                                            translation(context)!.sp_task10snackbarTitle,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          messageText: Text(
                                            translation(context)!.snackbarContent,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFF2F4771),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.open,
                                              style: const TextStyle(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.sp_task4Mech,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl ? FontWeight.w500 : FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() async {
                                        plumbingDocumentURL =
                                        (await uploadFileToCloudinaryNew())!;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.upload_file_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.upload,
                                              style: const TextStyle(
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
                                      if (plumbingDocumentURL != '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: plumbingDocumentURL,
                                        ));
                                      }  else {
                                        Get.snackbar(
                                          '',
                                          '',
                                          titleText: Text(
                                            translation(context)!.sp_task10snackbarTitle,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          messageText: Text(
                                            translation(context)!.snackbarContent,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFF2F4771),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.open,
                                              style: const TextStyle(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                          translation(context)!.sp_task4Elect,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: isRtl ? FontWeight.w500 : FontWeight.w800,
                                            fontSize: isRtl? 16: 19),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() async {
                                        electricalDocumentURL =
                                        (await uploadFileToCloudinaryNew())!;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.upload_file_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.upload,
                                              style: const TextStyle(
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
                                      if (electricalDocumentURL != '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: electricalDocumentURL,
                                        ));
                                      }  else {
                                        Get.snackbar(
                                          '',
                                          '',
                                          titleText: Text(
                                            translation(context)!.sp_task10snackbarTitle,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          messageText: Text(
                                            translation(context)!.snackbarContent,
                                            textAlign: isRtl ? TextAlign.left : TextAlign.right,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Color(0xFF2F4771),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin:
                                      const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child:  Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: isRtl? const EdgeInsets.only(right: 12.0):  const EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              translation(context)!.open,
                                              style: const TextStyle(
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
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        translation(context)!.yourNotes,                                        style: const TextStyle(
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
                                          hintText:  translation(context)!
                                              .enterNotesHere,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
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
                                                    .setTask4Data(
                                                  taskID,
                                                  taskProjectId,
                                                  designDocumentURL,
                                                  foundationDocumentURL,
                                                  plumbingDocumentURL,
                                                  electricalDocumentURL,
                                                  insulationAndHVACDocumentURL,
                                                  _userNotes.text,
                                                  'Update Data',
                                                );
                                              },
                                              child: Text(
                                                translation(context)!.save,
                                                style: const TextStyle(
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
                                                    if (areFieldsValid(designDocumentURL, foundationDocumentURL, plumbingDocumentURL,
                                                        electricalDocumentURL, insulationAndHVACDocumentURL, _userNotes.text)) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Directionality(
                                                            textDirection: translation(context)!.localeName == 'ar'
                                                                ? TextDirection.rtl
                                                                : TextDirection.ltr,
                                                            child: AlertDialog(
                                                              backgroundColor: Colors.white,
                                                              title: Text(translation(context)!.completeTask),
                                                              content: Text(translation(context)!.clickOkToComplete),
                                                              actions: [
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: Color(0xFFF3D69B),
                                                                  ),
                                                                  onPressed: () async {
                                                                    String message =
                                                                    await ServiceProviderGetTasksAPI
                                                                        .setTask4Data(
                                                                      taskID,
                                                                      taskProjectId,
                                                                      designDocumentURL,
                                                                      foundationDocumentURL,
                                                                      plumbingDocumentURL,
                                                                      electricalDocumentURL,
                                                                      insulationAndHVACDocumentURL,
                                                                      _userNotes
                                                                          .text,
                                                                      'Submit',
                                                                    );
                                                                    setState(() {
                                                                      designAndPlanningData[
                                                                      'TaskStatus'] =
                                                                      'Completed';
                                                                      isSubmitVisible =
                                                                      false;
                                                                    });
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text(
                                                                    translation(context)!.clickOk,
                                                                    style: const TextStyle(color: Color(0xFF2F4771), fontSize: 15),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: Color(0xFFF3D69B),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Text(
                                                                    translation(context)!.customCancel,
                                                                    style: const TextStyle(color: Color(0xFF2F4771), fontSize: 15),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      CustomAlertDialog.showErrorDialog(
                                                          context,
                                                          translation(context)!.customFill
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    translation(context)!.markAsDone,
                                                    style: const TextStyle(fontSize: 18, color: Color(0xFFF9FAFB)),
                                                  ),
                                                )),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
    ),
   );
  }
}
