import 'package:buildnex/tasks_SP/PropertSurvey/widgets/taskerProfile.dart';
import 'package:buildnex/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(GetMaterialApp(home: SpPropertySurvey()));
}

class SpPropertySurvey extends StatefulWidget {
  const SpPropertySurvey({super.key});

  @override
  State<SpPropertySurvey> createState() => _SpPropertySurveyState();
}

class _SpPropertySurveyState extends State<SpPropertySurvey> {

  final _landArea = TextEditingController();
  final _userNotes = TextEditingController();

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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: MediaQuery.of(context).size.height/6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color(0xFF2F4771),
                    width: 1.0,
                  ),
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
                          "Task #7777",
                          style: TextStyle(
                            color: Color(0xFFF9FAFB),
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0 , bottom: 10),
                                child: Text(
                                  "Task",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16
                                  ),
                                ),
                              ),
                              Text(
                                "Property Survey",
                                style: TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0 , bottom: 10),
                                child: Text(
                                  "Project",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Text(
                                "Nablus Project",
                                style: TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0 , bottom: 10),
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                "Not Started",
                                style: TextStyle(
                                    color: Color(0xFF2F4771),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                height: MediaQuery.of(context).size.height/7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color(0xFF2F4771),
                    width: 1.0,
                  ),
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
                          "Tasker",
                          style: TextStyle(
                              color: Color(0xFFF9FAFB),
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const TaskerProfileData(userPicture: 'images/Testing/Tokyo.jpg', rating: 3, numReviews: 40,),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                height: MediaQuery.of(context).size.height/2.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color(0xFF2F4771),
                    width: 1.0,
                  ),
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
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.landscape_outlined,
                                    color: Color(0xFF2F4771),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Land Area: ",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextfieldTasks(controller: _landArea, hintText: 'Enter Land Area Here', labelText: 'Land Area',),
                              ),
                            ],
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
                                    "Survey Document: ",
                                    style: TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontSize: 17,
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
                              "Notes: ",
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
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              controller: _userNotes,
                              style: TextStyle(color: Color(0xFF2F4771)),
                              decoration: InputDecoration(
                                hintText: "Enter Notes here if any",
                                hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                filled: true,
                                fillColor: Color(0xFFF9FAFB),
                                labelText: "Notes",
                                labelStyle: const TextStyle(
                                  color: Color(0xFF2F4771),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F4771),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F4771),
                                    width: 2.0,
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
