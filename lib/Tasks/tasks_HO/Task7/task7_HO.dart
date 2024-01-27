import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: PlumbingInstallHO()));
}

class PlumbingInstallHO extends StatefulWidget {
  const PlumbingInstallHO({super.key});

  @override
  State<PlumbingInstallHO> createState() => _PlumbingInstallHOState();
}

class _PlumbingInstallHOState extends State<PlumbingInstallHO> {
  final _userNotes = TextEditingController();

  Map<String, dynamic> task7Data = {};
  String taskID = '';
  String taskProjectId = '';

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task7Data = arguments['datatask7'];
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
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                TaskInformation(
                  taskID: task7Data['TaskID'] ?? 0,
                  taskName: 'Mechanical Work',
                  projectName: task7Data['ProjectName'] ?? 'Unknown',
                  taskStatus: task7Data['TaskStatus'] ?? 'Unknown',
                ),
                SPProfileData(
                  userPicture:
                      task7Data['UserPicture'] ?? 'images/profilePic96.png',
                  rating: (task7Data['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: task7Data['ReviewCount'] ?? 0,
                  userName: task7Data['Username'] ?? 'Unknown',
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
                        Container(
                          padding: const EdgeInsets.all(10),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  maxLines: 5,
                                  minLines: 5,
                                  enabled: false,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: task7Data['Notes'] ??
                                        translation(context)!.task1HONoNotesSP,
                                    hintStyle:
                                        TextStyle(color: Color(0xFF2F4771)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

