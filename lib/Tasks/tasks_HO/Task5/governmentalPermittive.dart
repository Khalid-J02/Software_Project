import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: GovernemntalPermittiveHO()));
}

class GovernemntalPermittiveHO extends StatefulWidget {
  const GovernemntalPermittiveHO({super.key});

  @override
  State<GovernemntalPermittiveHO> createState() =>
      _GovernemntalPermittiveHOState();
}

class _GovernemntalPermittiveHOState extends State<GovernemntalPermittiveHO> {
  //final String _governmentalAccept = "Accept" ;

  Map<String, dynamic> task5Data = {};
  String taskID = '';
  String taskProjectId = '';
  String approvalDocuments = '';
  double? _progress;

  late Map<String, dynamic> Data;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task5Data = arguments['GovernmentData'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: Text(
              translation(context)!.task1HOMainTitle,
              style: TextStyle(color: Colors.white),
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
                  taskID: task5Data['TaskID'] ?? 0,
                  taskName: translation(context)!.task5HOTaskName,
                  projectName: task5Data['ProjectName'] ?? 'Unknown',
                  taskStatus: task5Data['TaskStatus'] ?? 'Unknown',
                ),
                SPProfileData(
                  userPicture:
                      task5Data['UserPicture'] ?? 'images/profilePic96.png',
                  rating: (task5Data['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: task5Data['ReviewCount'] ?? 0,
                  userName: task5Data['Username'] ?? 'Unknown',
                  taskId: taskID,
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
                          child: Center(
                            child: Text(
                              translation(context)!.task1HOServiceProviderDetailsTitle,
                              style: const TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          padding: const EdgeInsets.all(8),
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
                                        right: 0,
                                        top: 5,
                                      ),
                                      child: Text(
                                        translation(context)!.task5HOApprovalDocument, // we should give another name
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (task5Data['ApprovalsDocument'] !=
                                                '') {
                                              FileDownloader.downloadFile(
                                                url: task5Data[
                                                    'ApprovalsDocument'],
                                                onProgress: (name, progress) {
                                                  setState(() {
                                                    _progress = _progress;
                                                  });
                                                },
                                                onDownloadCompleted: (value) {
                                                  setState(() {
                                                    _progress = null;
                                                  });
                                                },
                                              );
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
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
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 2, right: 8)
                                                      :
                                                  const EdgeInsets.only(left: 8, right: 2),
                                                  child: const Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 8)
                                                      :
                                                  const EdgeInsets.only(right: 8),
                                                  child: Text(
                                                    translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 14,
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
                                      if (task5Data['ApprovalsDocument'] !=
                                          '') {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL:
                                              task5Data['ApprovalsDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 0),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 2, right: 8)
                                                :
                                            const EdgeInsets.only(left: 8, right: 2),
                                            child: const Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 6)
                                                :
                                            const EdgeInsets.only(right: 6),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 14,
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
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        translation(context)!.task1HOServiceProviderNotes,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: TextFormField(
                                        maxLines: 5,
                                        minLines: 5,
                                        enabled: false,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: task5Data['Notes'] ??
                                              translation(context)!.task1HONoNotesSP,
                                          hintStyle:
                                              TextStyle(color: Color(0xFF2F4771)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF2F4771),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
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
    );
  }
}
