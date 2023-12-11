import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              TaskInformation(taskID: 7777, taskName: 'Governmental Permitting', projectName: 'Nablus Project', taskStatus: 'Not Started',),
              const SPProfileData(userPicture: 'images/Testing/Tokyo.jpg', userName: 'Khalid Jabr' , rating: 3.4, numReviews: 32,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                height: MediaQuery.of(context).size.height/2.2,
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
                      height: MediaQuery.of(context).size.height/2.6,
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
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Survey Document: ",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5 , right: 15),
                                  height: 35,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F4771),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: const Icon(
                                      Icons.upload_file_outlined,
                                      size: 20,
                                      color: Color(0xFFF9FAFB),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                    "Land Ownership Document: ",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5 , right: 15),
                                  height: 35,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F4771),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: IconButton(
                                    onPressed: (){},
                                    icon: const Icon(
                                      Icons.upload_file_outlined,
                                      size: 20,
                                      color: Color(0xFFF9FAFB),
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
                                hintText: "There is no notes yet .. ",
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
              Container(
                width: 250,
                decoration: const BoxDecoration(
                  color: Color(0xFF2F4771),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF9FAFB),
                    ),
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
