import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../APIRequests/homeOwnerTasksAPI.dart';


void main() {
  runApp(GetMaterialApp(home: PlumbingInstallHO()));
}

class PlumbingInstallHO extends StatefulWidget {
  const PlumbingInstallHO({super.key});

  @override
  State<PlumbingInstallHO> createState() => _PlumbingInstallHOState();
}

class _PlumbingInstallHOState extends State<PlumbingInstallHO> {

  final _userNotes = TextEditingController() ;


  Map<String, dynamic> task7Data = {};
  String taskID = '';
  String taskProjectId = '';

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

      setState(() {
        task7Data = data;
      });

    } catch (e) {
      print('Error fetching task7 data: $e');
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
              TaskInformation(taskID: task7Data['TaskID']?? 0, taskName: task7Data['TaskName']?? 'Unknown', projectName: task7Data['ProjectName']?? 'Unknown', taskStatus: task7Data['TaskStatus']?? 'Unknown',),
              SPProfileData(userPicture: task7Data['UserPicture']?? 'images/profilePic96.png', rating: (task7Data['Rating'] as num?)?.toDouble() ?? 0.0, numReviews: task7Data['ReviewCount']?? 0, userName:task7Data['Username']?? 'Unknown',),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
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
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Service Provider Notes: ",
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
                                  hintText:  task7Data['Notes'] ?? 'No notes available',
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

// Container(
//   margin: const EdgeInsets.only(top: 5),
//   padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(20.0),
//   ),
//   child: Card(
//     elevation: 5,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20.0),
//         topRight: Radius.circular(20.0),
//         bottomLeft: Radius.zero,
//         bottomRight: Radius.zero,
//       ),
//     ),
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 14),
//           decoration: BoxDecoration(
//             color: Color(0xFF6781A6),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20.0),
//               topRight: Radius.circular(20.0),
//               bottomLeft: Radius.zero,
//               bottomRight: Radius.zero,
//             ),
//             border: Border.all(
//               color: Color(0xFF2F4771),
//               width: 1.0,
//             ),
//           ),
//           child: const Center(
//             child: Text(
//               "Task Details",
//               style: TextStyle(
//                   color: Color(0xFFF9FAFB),
//                   fontSize: 19,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10.0),
//         Container(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 8 ,right: 8),
//                       child: Text(
//                         "Plumbing Document:",
//                         style: TextStyle(
//                             color: Color(0xFF2F4771),
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5 , right: 5),
//                     height: 35,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF2F4771),
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     child: const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 8 , right: 8),
//                           child: Icon(
//                             Icons.upload_file_outlined,
//                             size: 20,
//                             color: Color(0xFFF9FAFB),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(right: 12.0),
//                           child: Text(
//                             "Upload",
//                             style: TextStyle(
//                               color: Color(0xFFF9FAFB),
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 5 , right: 5),
//                     height: 35,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF2F4771),
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     child: const Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 8 , right: 8),
//                           child: Icon(
//                             Icons.delete_outline_outlined,
//                             size: 20,
//                             color: Color(0xFFF9FAFB),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(right: 12.0),
//                           child: Text(
//                             "Delete",
//                             style: TextStyle(
//                               color: Color(0xFFF9FAFB),
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox( height: 10,),
//               Row(
//                 children: [
//                   const Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 8 ,right: 8),
//                       child: Text(
//                         "Price / Unit:",
//                         style: TextStyle(
//                             color: Color(0xFF2F4771),
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF9FAFB),
//                         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//                         border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "Not assigned",
//                           style: TextStyle(
//                               color: Color(0xFF2F4771),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text(
//                   "Provider Notes: ",
//                   style: TextStyle(
//                       color: Color(0xFF2F4771),
//                       fontSize: 17,
//                       fontWeight: FontWeight.w400
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 140,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: TextFormField(
//                   maxLines: 5,
//                   minLines: 5,
//                   enabled: false,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: "There is no notes yet .. ",
//                     hintStyle: TextStyle(color: Color(0xFF2F4771)),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF2F4771),
//                       ),
//                     ),
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF2F4771),
//                         width: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Container(
//   width: 250,
//   margin: EdgeInsets.symmetric(vertical: 12),
//   decoration: const BoxDecoration(
//     color: Color(0xFF2F4771),
//     borderRadius: BorderRadius.all(Radius.circular(30.0)),
//   ),
//   child: TextButton(
//     onPressed: () {},
//     child: const Text(
//       'Save',
//       style: TextStyle(
//         fontSize: 20,
//         color: Color(0xFFF9FAFB),
//       ),
//     ),
//   ),
// ),
