import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: TaskReviewHO(),));
}

class TaskReviewHO extends StatefulWidget {
  const TaskReviewHO({super.key});

  @override
  State<TaskReviewHO> createState() => _TaskReviewHOState();
}

class _TaskReviewHOState extends State<TaskReviewHO> {

  int _providerRating = 1 ;
  final _userNotes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF3D69B),
        ),
        title: const Padding(
          padding: EdgeInsets.only(right: 49.0),
          child: Center(
            child: Text(
              //projectName,
              "Task Review",
              style: TextStyle(color: Color(0xFFF3D69B)),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                // TaskInformation(taskID: 7777, taskName: 'Property Survey', projectName: 'Nablus Project', taskStatus: 'Not Started',),
                SPProfileData(userPicture: 'images/Testing/Tokyo.jpg', rating: 3.6, numReviews: 15, userName: 'Khalid Jabr',),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
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
                              "Review Task Provider",
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
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star_rate_outlined,
                                          color: Color(0xFF2F4771),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "Rating : ",
                                            style: TextStyle(
                                                color: Color(0xFF2F4771),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox( height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: RatingBarSB(rating: _providerRating.toDouble() , size: 25,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF2F4771),//Color(0xFFF9FAFB),
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 12,
                                                        offset: const Offset(0,3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      if(_providerRating == 1){
                                                        _providerRating = 1 ;
                                                      }
                                                      else{
                                                        _providerRating = _providerRating - 1 ;
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(CupertinoIcons.minus , size: 15, color: Color(0xFFF9FAFB),),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Text(
                                                  _providerRating.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xFF2F4771),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF2F4771),
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 12,
                                                        offset: const Offset(0,3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      if(_providerRating == 5){
                                                        _providerRating = 5 ;
                                                      }
                                                      else{
                                                        _providerRating = _providerRating + 1 ;
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add ,size: 15, color: Color(0xFFF9FAFB),),
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
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Review : ",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  minLines: 8,
                                  controller: _userNotes,
                                  style: TextStyle(color: Color(0xFF2F4771)),
                                  decoration: InputDecoration(
                                    hintText: "Add a review",
                                    hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                    filled: true,
                                    fillColor: Color(0xFFF9FAFB),
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
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
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
                              "Review Used Item",
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
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 0 , bottom: 12 ),
                                  height: 200,
                                  width: 200,
                                  child: Image.network(
                                    "https://picsum.photos/200/300",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 25),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Color(0xFF2F4771) , width: 1.8),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Ceramic Tile #89E",
                                      style: TextStyle(
                                          color: Color(0xFF2F4771),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star_rate_outlined,
                                          color: Color(0xFF2F4771),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "Rating : ",
                                            style: TextStyle(
                                                color: Color(0xFF2F4771),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox( height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: RatingBarSB(rating: _providerRating.toDouble() , size: 25,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF2F4771),//Color(0xFFF9FAFB),
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 12,
                                                        offset: const Offset(0,3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      if(_providerRating == 1){
                                                        _providerRating = 1 ;
                                                      }
                                                      else{
                                                        _providerRating = _providerRating - 1 ;
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(CupertinoIcons.minus , size: 15, color: Color(0xFFF9FAFB),),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: Text(
                                                  _providerRating.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xFF2F4771),
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF2F4771),
                                                    borderRadius: BorderRadius.circular(20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 12,
                                                        offset: const Offset(0,3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      if(_providerRating == 5){
                                                        _providerRating = 5 ;
                                                      }
                                                      else{
                                                        _providerRating = _providerRating + 1 ;
                                                      }
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add ,size: 15, color: Color(0xFFF9FAFB),),
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
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Review : ",
                                  style: TextStyle(
                                      color: Color(0xFF2F4771),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  minLines: 8,
                                  controller: _userNotes,
                                  style: TextStyle(color: Color(0xFF2F4771)),
                                  decoration: InputDecoration(
                                    hintText: "Add a review",
                                    hintStyle: TextStyle(color: Color(0xFF2F4771)),
                                    filled: true,
                                    fillColor: Color(0xFFF9FAFB),
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
                ),  // a condition will be applied on this widget so that the sp who have catalog will appear for them otherwise no
                Center(
                  child: Container(
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}