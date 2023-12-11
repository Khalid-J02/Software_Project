import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/taskWidgets/taskProviderInformation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(GetMaterialApp(home: SoilTestingSP()));
}

class SoilTestingSP extends StatefulWidget {
  const SoilTestingSP({super.key});

  @override
  State<SoilTestingSP> createState() => _SoilTestingSPState();
}

class _SoilTestingSPState extends State<SoilTestingSP> {

  String _soilTypeValue = 'Select Soil Type';
  String _soilWaterHoldingCapacity = 'Select Capacity' ;
  String _soilDrainageTest = 'Select a Type';
  String _soilBearingCapacity = 'Select Capacity' ;
  String _soilBedrockOrGroundWater = 'Select an Option' ;
  String _soilPH = 'Select an Option' ;
  String _soilOverallTest = 'Select a Result' ;

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
              TaskProviderInformation(rating: 3.5, numOfReviews: 55,),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
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
                              Container(
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
                                      _soilTypeValue = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 10.0 , left: 12),
                                    child: Text(
                                      _soilTypeValue,
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
                                      value: 'Sandy',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 33.0 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('Sandy'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Silty',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Silty'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Clay',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Clay'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Loamy',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Loamy'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Peaty',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Peaty'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Chalky',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Chalky'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
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
                              Container(
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
                                      _soilWaterHoldingCapacity = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 12 , right: 10),
                                    child: Text(
                                      _soilWaterHoldingCapacity,
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
                                      value: 'High',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 33.0 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('High'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Moderate',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Moderate'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Low',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Low'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
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
                              Container(
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
                                      _soilDrainageTest = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Text(
                                      _soilDrainageTest,
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
                                      value: 'Well-drained',
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('Well-drained'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Moderately drained',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Moderately drained'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Poorly drained',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Poorly drained'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8 ,right: 8),
                                child: Text(
                                  "Soil Bearing Capacity:",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Container(
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
                                      _soilBearingCapacity = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 10.0 , left: 12),
                                    child: Text(
                                      _soilBearingCapacity,
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
                                      value: 'High',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 33.0 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('High'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Moderate',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Moderate'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Low',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Low'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8 ,right: 8 , bottom: 4),
                                child: Text(
                                  "Bedrock & GroundWater Test:",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Container(
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
                                      _soilBedrockOrGroundWater = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 10.0 , left: 12),
                                    child: Text(
                                      _soilBedrockOrGroundWater,
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
                                      value: 'Bedrock present, Groundwater present',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 33.0 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('Bedrock present, Groundwater present'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Bedrock present, Groundwater absent',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Bedrock present, Groundwater absent'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Bedrock absent, Groundwater present',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Bedrock absent, Groundwater present'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Bedrock absent, Groundwater absent',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Bedrock absent, Groundwater absent'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8 ,right: 8),
                                child: Text(
                                  "Soil pH Test:",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Container(
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
                                      _soilPH = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 10.0 , left: 12),
                                    child: Text(
                                      _soilPH,
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
                                      value: 'Very acidic',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 33.0 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('Very acidic'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Acidic',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Acidic'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Neutral',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Neutral'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Alkaline',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Alkaline'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Very alkaline',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('Very alkaline'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox( height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8 ,right: 8),
                                child: Text(
                                  "Overall Result:",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
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
                                      _soilOverallTest = value!;
                                    });
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 30.0 , left: 12),
                                    child: Text(
                                      _soilOverallTest,
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
                                      value: 'Approved. Suitable for Construction',
                                      child: Container(
                                        padding: const EdgeInsets.only(right: 5 , left: 12),
                                        // margin: const EdgeInsets.all(12.0),
                                        child: const Text('Approved. Suitable for Construction'),
                                      ),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Disapproved, can\'t build over it',
                                      child: Container(
                                        margin: const EdgeInsets.all(12.0),
                                        child: const Text('can\'t build over it'),
                                      ),
                                    ),
                                  ],
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
                    ),
                  ],
                ),
              ),
              Container(
                width: 250,
                margin: EdgeInsets.only(bottom: 12),
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


// validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a task name';
//                         }
//                         return null;
//                       },

// this is for any textform field