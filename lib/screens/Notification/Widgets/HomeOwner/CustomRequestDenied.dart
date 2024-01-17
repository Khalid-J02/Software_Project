import 'package:flutter/material.dart';

class CustomRequestDeniedNotification extends StatefulWidget {
  const CustomRequestDeniedNotification({super.key});

  @override
  State<CustomRequestDeniedNotification> createState() => _CustomRequestDeniedNotificationState();
}

class _CustomRequestDeniedNotificationState extends State<CustomRequestDeniedNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage('https://res.cloudinary.com/df1qhofpr/image/upload/v1705153999/profileImages/jho6sahyvbzyfx8nm1tv.jpg'),
          ),
          const SizedBox(width: 15,),
          const Column(
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
                "Has Denied your task assigning",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,

                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFF022D6B),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: TextButton(
                onPressed: (){
                  /*
                  Open Dialog to let him see the reason to deny the task
                   */
                },
                child: const Text(
                  "See More",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
