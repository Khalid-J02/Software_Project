import 'package:flutter/material.dart';

import '../tasks_SP/PropertSurvey/widgets/taskerProfile.dart';

class TaskProviderInformation extends StatefulWidget {
  double rating ;
  int numOfReviews ;
  /*
  you need to add the image here
   */

  TaskProviderInformation(
      {
        super.key,
        required this.rating,
        required this.numOfReviews
      }
  );

  @override
  State<TaskProviderInformation> createState() => _TaskProviderInformationState();
}

class _TaskProviderInformationState extends State<TaskProviderInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
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
                  "Task Provider",
                  style: TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TaskerProfileData(userPicture: 'images/Testing/Tokyo.jpg', rating: widget.rating, numReviews: widget.numOfReviews,),
            ),
          ],
        ),
      ),
    );
  }
}
