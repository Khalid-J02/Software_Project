import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';

import '../../../APIRequests/homeOwnerTasksAPI.dart';
import 'Widgets/serviceProviderProfleData.dart';


void main() {
  runApp(GetMaterialApp(home: LocalGovernoratePermits()));
}

class LocalGovernoratePermits extends StatefulWidget {
  const LocalGovernoratePermits({super.key});

  @override
  State<LocalGovernoratePermits> createState() => _LocalGovernoratePermitsState();
}

class _LocalGovernoratePermitsState extends State<LocalGovernoratePermits> {
  Map<String, dynamic> task2Data = {};
  String taskID = '';
  String taskProjectId = '';
  String permitsDocument = '';
  double? _progress ;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task2Data = arguments['localGovernmentData'] ;
      permitsDocument = arguments['docsURL'] ;
    });
    // fetchArgumentsAndData();
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
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              TaskInformation(taskID: task2Data['TaskID']?? 0, taskName:"Regulatory Information", projectName: task2Data['ProjectName']?? 'Unknown', taskStatus: task2Data['TaskStatus']?? 'Unknown',),
              SPProfileData(userPicture: task2Data['UserPicture']?? 'images/profilePic96.png', rating: (task2Data['Rating'] as num?)?.toDouble() ?? 0.0, numReviews: task2Data['ReviewCount']?? 0, userName:task2Data['Username']?? 'Unknown',),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/17 ,
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
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Permits Document: ",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                                _progress != null
                                    ? const CircularProgressIndicator()
                                    :
                                GestureDetector(
                                  onTap: (){
                                    FileDownloader.downloadFile(
                                      url: permitsDocument,
                                      onProgress: (name , progress){
                                        setState(() {
                                          _progress = _progress;
                                        });
                                      },
                                      onDownloadCompleted: (value){
                                        setState(() {
                                          _progress = null ;
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5 , right: 5),
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2F4771),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.sim_card_download,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "Download",
                                            style: TextStyle(
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
                                  onTap: (){
                                    Get.to(DocsPdfViewer(pdfFileURL: permitsDocument,)) ;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5 , right: 5),
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2F4771),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8 , right: 4),
                                          child: Icon(
                                            Icons.file_open_outlined,
                                            size: 20,
                                            color: Color(0xFFF9FAFB),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "Open",
                                            style: TextStyle(
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
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Task Provider Notes: ",
                              style: TextStyle(
                                  color: Color(0xFF2F4771),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Container(
                            height: 140,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              maxLines: 5,
                              minLines: 5,
                              enabled: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: task2Data['Notes'] ?? 'No notes available',
                                hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F4771),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
