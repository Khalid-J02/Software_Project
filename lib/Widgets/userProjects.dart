import 'package:flutter/material.dart';

class UserProjects extends StatelessWidget {

  final String projectName ;
  const UserProjects({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25 , right: 25 , top: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFcce2e6),
          borderRadius: BorderRadius.circular(12)
        ),
        child: GestureDetector(
          onTap: (){
            // change the color + get the project id and send it in request to the server to get project page
          },
          child: Text(projectName,
            style: const TextStyle(
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
