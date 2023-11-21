import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/projectNav_homeOwner.dart';

class UserProjects extends StatelessWidget {

  final String projectName ;
  const UserProjects({super.key, required this.projectName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/HomePage/HomeOwner/ProjectPage');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 25 , right: 25 , top: 25),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFF3D69B)
            )
          ),
          child: Text(projectName,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFFF3D69B)
            ),
          ),
        ),
      ),
    );
  }
}
