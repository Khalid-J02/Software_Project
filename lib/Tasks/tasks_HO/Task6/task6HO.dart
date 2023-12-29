import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/homeOwnerTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';


void main() {
  runApp(GetMaterialApp(home: ConstructionHO()));
}

class ConstructionHO extends StatefulWidget {
  const ConstructionHO({super.key});

  @override
  State<ConstructionHO> createState() => _ConstructionHOState();
}

class _ConstructionHOState extends State<ConstructionHO> {

  String _materialProvider = 'Select an Option' ;
  //final _userNotes = TextEditingController() ;


  Map<String, dynamic> task6Data = {};
  String taskID = '';
  String taskProjectId = '';
  String? materialProvider;

  @override
  void initState() {
    super.initState();
    fetchArgumentsAndData();
  }

  Future<void> fetchArgumentsAndData() async {
    try {

      Map<String, dynamic> arguments = Get.arguments;
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];

      final Map<String, dynamic> data =
      await HomeOwnerTasksAPI.getTask6(taskID);

      final Map<String, dynamic> getMatiralProvider = await HomeOwnerTasksAPI.getProjectInfoData( int.parse(taskProjectId));

      setState(() {
        task6Data = data;
        materialProvider =  getMatiralProvider['MaterialProvider'] != null
            ? getMatiralProvider['MaterialProvider']
            : null;

        if(materialProvider != null)
        {
          _materialProvider = materialProvider.toString();
        }
      });

    } catch (e) {
      print('Error fetching task6 data: $e');
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
              TaskInformation(taskID: task6Data['TaskID']?? 0, taskName: task6Data['TaskName']?? 'Unknown', projectName: task6Data['ProjectName']?? 'Unknown', taskStatus: task6Data['TaskStatus']?? 'Unknown',),
              SPProfileData(userPicture: task6Data['UserPicture']?? 'images/profilePic96.png', rating: (task6Data['Rating'] as num?)?.toDouble() ?? 0.0, numReviews: task6Data['ReviewCount']?? 0, userName:task6Data['Username']?? 'Unknown',),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
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
                          "Home Owner Choice",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8 ,right: 8),
                                  child: Text(
                                    "Construction Material provider:",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: DropdownButton<String>(
                                    style: const TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400
                                    ),

                                    onChanged: (String? value) {
                                      setState(() {
                                        _materialProvider = value!;
                                      });
                                    },
                                    hint: Padding(
                                      padding: const EdgeInsets.only(right: 10.0 , left: 12),
                                      child: Text(
                                        _materialProvider,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: '',
                                        child: Container(
                                          margin: const EdgeInsets.all(12.0),
                                          child: const Text(''),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: 'Me -HomeOwner-',
                                        child: Container(
                                          padding: const EdgeInsets.only(right: 0.0 , left: 12),
                                          // margin: const EdgeInsets.all(12.0),
                                          child: const Text('Me -HomeOwner-'),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: 'Service Provider',
                                        child: Container(
                                          margin: const EdgeInsets.all(12.0),
                                          child: const Text('Service Provider'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Center(
                            child: Container(
                              width: 250,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2F4771),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final savedData = await HomeOwnerTasksAPI.saveMaterialProvider(int.parse(taskProjectId), _materialProvider);
                                  CustomAlertDialog.showSuccessDialog(context, "Material Provider saved successfully");
                                  return;
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFF9FAFB),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Task Provider Notes: ",
                              style: TextStyle(
                                  color: Color(0xFF2F4771),
                                  fontSize: 17,
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
                                hintText:  task6Data['Notes'] ?? 'No notes available',
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
                          // const Padding(
                          //   padding: EdgeInsets.all(10),
                          //   child: Text(
                          //     "Notes: ",
                          //     style: TextStyle(
                          //         color: Color(0xFF2F4771),
                          //         fontSize: 17,
                          //         fontWeight: FontWeight.w400
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   height: 120,
                          //   padding: const EdgeInsets.symmetric(horizontal: 8),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.multiline,
                          //     textInputAction: TextInputAction.newline,
                          //     maxLines: null,
                          //     controller: _userNotes,
                          //     style: TextStyle(color: Color(0xFF2F4771)),
                          //     decoration: InputDecoration(
                          //       hintText: "Enter Notes here if any",
                          //       hintStyle: TextStyle(color: Color(0xFF2F4771)),
                          //       filled: true,
                          //       fillColor: Color(0xFFF9FAFB),
                          //       labelText: "Notes",
                          //       labelStyle: const TextStyle(
                          //         color: Color(0xFF2F4771),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         borderSide: const BorderSide(
                          //           color: Color(0xFF2F4771),
                          //         ),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //         borderSide: const BorderSide(
                          //           color: Color(0xFF2F4771),
                          //           width: 2.0,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
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
    );
  }
}
