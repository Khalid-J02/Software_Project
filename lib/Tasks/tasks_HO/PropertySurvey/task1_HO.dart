import 'package:buildnex/Tasks/taskWidgets/landInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

class HOPropertySurvey extends StatefulWidget {
  const HOPropertySurvey({super.key});

  @override
  State<HOPropertySurvey> createState() => _HOPropertySurveyState();
}

class _HOPropertySurveyState extends State<HOPropertySurvey> {
  Map<String, dynamic> propertySurveyData = {};
  String taskID = '';
  String taskProjectId = '';
  String? surveyDocument = '';
  double? _progress;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      propertySurveyData = arguments['propertySurveyData'];
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      if(arguments['docsURL'] != null){
        surveyDocument = arguments['docsURL'];
      }
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
              style: const TextStyle(color: Colors.white),
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
                  taskName: translation(context)!.task1HOTaskName,
                  projectName: propertySurveyData['ProjectName'] ?? 'Unknown',
                  taskStatus: propertySurveyData['TaskStatus'] ?? 'Unknown',
                ),
                LandInformation(
                  basinNumber: propertySurveyData['BasinNumber'] ?? 'Unknown',
                  plotNumber: propertySurveyData['PlotNumber'] ?? 'Unknown',
                ),
                SPProfileData(
                  userPicture: propertySurveyData['UserPicture'],
                  rating:
                      (propertySurveyData['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: propertySurveyData['ReviewCount'] ?? 0,
                  userName: propertySurveyData['Username'] ?? 'Unknown',
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
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.landscape_outlined,
                                            color: Color(0xFF2F4771),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(
                                            translation(context)!.task1HOLandArea,
                                            style: const TextStyle(
                                                color: Color(0xFF2F4771),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
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
                                          (propertySurveyData['PropertySize']
                                                  as String?) ??
                                              '0',
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
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          top: 14,
                                        ),
                                        child: Text(
                                          translation(context)!.task1HOSurveyDocument,
                                          style: const TextStyle(
                                              color: Color(0xFF2F4771),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    _progress != null
                                        ? const CircularProgressIndicator()
                                        : GestureDetector(
                                            onTap: () {
                                              if(surveyDocument != null){
                                                FileDownloader.downloadFile(
                                                  url: surveyDocument!,
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
                                              }
                                              else{
                                                Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                              }

                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, right: 5),
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF2F4771),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: translation(context)!.localeName == 'ar'
                                                        ?
                                                    const EdgeInsets.only(left: 2, right: 8)
                                                        :
                                                    const EdgeInsets.only(left: 8, right: 0),
                                                    child: const Icon(
                                                      Icons.sim_card_download,
                                                      size: 20,
                                                      color: Color(0xFFF9FAFB),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: translation(context)!.localeName == 'ar' ?
                                                    const EdgeInsets.only(left: 8.0)
                                                        :
                                                    const EdgeInsets.only(right: 8.0),
                                                    child: Text(
                                                      translation(context)!.downloadLabelButton,
                                                      style: const TextStyle(
                                                        color: Color(0xFFF9FAFB),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        if(surveyDocument != null){
                                          Get.to(DocsPdfViewer(
                                            pdfFileURL: surveyDocument!,
                                          ));
                                        }
                                        else{
                                          Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
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
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: translation(context)!.localeName == 'ar'
                                                  ?
                                              const EdgeInsets.only(left: 2, right: 8)
                                                  :
                                              const EdgeInsets.only(left: 8, right: 0),
                                              child: const Icon(
                                                Icons.file_open_outlined,
                                                size: 20,
                                                color: Color(0xFFF9FAFB),
                                              ),
                                            ),
                                            Padding(
                                              padding: translation(context)!.localeName == 'ar' ?
                                              const EdgeInsets.only(left: 8.0)
                                                  :
                                              const EdgeInsets.only(right: 8.0),
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
                                          hintText: propertySurveyData['Notes'] ??
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
