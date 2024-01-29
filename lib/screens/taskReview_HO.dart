import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/homeOwnerReviewAPI.dart';
import '../Widgets/customAlertDialog.dart';
import '../Widgets/serviceProviderDataReview.dart';

void main() {
  runApp(GetMaterialApp(
    home: TaskReviewHO(),
  ));
}

class TaskReviewHO extends StatefulWidget {
  const TaskReviewHO({super.key});

  @override
  State<TaskReviewHO> createState() => _TaskReviewHOState();
}

class _TaskReviewHOState extends State<TaskReviewHO> {
  int _providerRating = 1;
  final _userNotes = TextEditingController();

  String taskID = '';
  String userPicture = '';
  String userName = '';
  double rating = 0.0;
  int numReviews = 0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      userPicture = arguments['userPicture'];
      userName = arguments['userName'];
      rating = arguments['rating'].toDouble();
      numReviews = arguments['numReviews'].toInt();
    });
    _fetchReviewDetails();
  }

  void _fetchReviewDetails() async {
    try {
      final reviewData = await HomeOwnerReviewAPI.getReviewDetails(taskID);
      if (reviewData['ReviewID'] != null) {
        setState(() {
          _userNotes.text = reviewData['ReviewContent'];
          _providerRating = reviewData['Rating'];
        });
      }
    } catch (e) {
      print('Failed to fetch review details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            //projectName,
            translation(context)!.taskReviewHOMainTitle,
            style: TextStyle(color: Colors.white),
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
                  SPProfileDataReview(
                    userPicture: userPicture,
                    rating: rating,
                    numReviews: numReviews,
                    userName: userName,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                            height: MediaQuery.of(context).size.height / 17,
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
                            child: Center(
                              child: Text(
                                translation(context)!.taskReviewHOReviewTask,
                                style: TextStyle(
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
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star_rate_outlined,
                                            color: Color(0xFF2F4771),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              translation(context)!.taskReviewHORating,
                                              style: TextStyle(
                                                  color: Color(0xFF2F4771),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 12.0),
                                            child: RatingBarSB(
                                              rating: _providerRating.toDouble(),
                                              size: 25,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF2F4771), //Color(0xFFF9FAFB),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 12,
                                                          offset:
                                                              const Offset(0, 3),
                                                        )
                                                      ]),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_providerRating ==
                                                            1) {
                                                          _providerRating = 1;
                                                        } else {
                                                          _providerRating =
                                                              _providerRating - 1;
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      CupertinoIcons.minus,
                                                      size: 15,
                                                      color: Color(0xFFF9FAFB),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    _providerRating.toString(),
                                                    style: const TextStyle(
                                                        color: Color(0xFF2F4771),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color(0xFF2F4771),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 12,
                                                          offset:
                                                              const Offset(0, 3),
                                                        )
                                                      ]),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_providerRating ==
                                                            5) {
                                                          _providerRating = 5;
                                                        } else {
                                                          _providerRating =
                                                              _providerRating + 1;
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 15,
                                                      color: Color(0xFFF9FAFB),
                                                    ),
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
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          translation(context)!.taskReviewHOAddReview,
                                          style: TextStyle(
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
                                          textInputAction:
                                              TextInputAction.newline,
                                          maxLines: null,
                                          minLines: 8,
                                          controller: _userNotes,
                                          style:
                                              TextStyle(color: Color(0xFF2F4771)),
                                          decoration: InputDecoration(
                                            hintText: translation(context)!.taskReviewHOAddReview,
                                            hintStyle: TextStyle(
                                                color: Color(0xFF2F4771)),
                                            filled: true,
                                            fillColor: Color(0xFFF9FAFB),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                color: Color(0xFF2F4771),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    width: 300,
                                    // margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2F4771),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (_providerRating > 0 &&
                                            _userNotes.text.isNotEmpty) {
                                          final data = await HomeOwnerReviewAPI
                                              .addOrUpdateReview(
                                                  taskID,
                                                  _userNotes.text,
                                                  _providerRating);
                                          CustomAlertDialog.showSuccessDialog(
                                              context,
                                              'Review submitted successfully');
                                          setState(() {
                                            rating = data['serviceProviderRating']
                                                .toDouble();
                                            numReviews =
                                                data['serviceProviderNumReviews'];
                                          });
                                        } else {
                                          CustomAlertDialog.showErrorDialog(
                                              context,
                                              'Please provide a rating and review notes');
                                        }
                                      },
                                      child: Text(
                                        translation(context)!.task4HODemandsSaveButton,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
