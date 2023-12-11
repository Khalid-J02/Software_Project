import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(GetMaterialApp(home: SoilTesting()));
}

class SoilTesting extends StatefulWidget {
  const SoilTesting({super.key});

  @override
  State<SoilTesting> createState() => _SoilTestingState();
}

class _SoilTestingState extends State<SoilTesting> {

  String _soilTypeValue = 'Data1';
  String _soilWaterHoldingCapacity = 'Data2' ;
  String _soilDrainageTest = 'Data3';
  String _soilBearingCapacity = 'Data4' ;
  String _soilBedrockOrGroundWater = 'Data5' ;
  String _soilPH = 'Data6' ;
  String _soilOverallTest = 'Data7' ;

  final _userNotes = TextEditingController() ;

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
              TaskInformation(taskID: 7777, taskName: 'Soil Testing', projectName: 'Nablus Project', taskStatus: 'Not Started',),
              SPProfileData(userPicture: 'images/Testing/Tokyo.jpg', rating: 3.6, numReviews: 15, userName: 'Khalid Jabr',),
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
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8 ,right: 8),
                                  child: Text(
                                    "Soil Type Test:",
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilTypeValue,
                                      style: const TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Water-Holding Capacity:",
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
                                  width: 180,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilWaterHoldingCapacity,
                                      style: const TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Soil Drainage Test:",
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilDrainageTest,
                                      style: const TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Soil Bearing Capacity:",
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilBearingCapacity,
                                      style: const TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Precence of Bedrock & Groundwater Test:",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(horizontal: 12),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFB),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                ),
                                child: Center(
                                  child: Text(
                                    _soilBedrockOrGroundWater,
                                    style: const TextStyle(
                                        color: Color(0xFF2F4771),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Soil pH Test:",
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
                                  padding: EdgeInsets.all(10) ,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilPH,
                                      style: const TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    "Overall Test Result:",
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
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _soilOverallTest,
                                      style: const TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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


// validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a task name';
//                         }
//                         return null;
//                       },

// this is for any textform field