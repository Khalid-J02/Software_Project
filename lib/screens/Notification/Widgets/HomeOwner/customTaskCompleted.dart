import 'package:flutter/material.dart';

class CustomTaskCompletedNotification extends StatefulWidget {
  const CustomTaskCompletedNotification({super.key});

  @override
  State<CustomTaskCompletedNotification> createState() => _CustomTaskCompletedNotificationState();
}

class _CustomTaskCompletedNotificationState extends State<CustomTaskCompletedNotification> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage('https://res.cloudinary.com/df1qhofpr/image/upload/v1705153999/profileImages/jho6sahyvbzyfx8nm1tv.jpg'),
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  "Khalid Jabr",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Has Finished Working on the assign Task",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,

                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
