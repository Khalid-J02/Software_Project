import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/projectNav_homeOwner.dart';

class UserProjects extends StatelessWidget {

  final String projectName ;
  final String projectId;
  final String projectStatus ;

  //const UserProjects({super.key, required this.projectName});
  const UserProjects({Key? key, required this.projectId, required this.projectName, required this.projectStatus})
      : super(key: key);

  Color getBorderColorBasedOnStatus(String status) {
    if (status == 'Not Started') {
      return const Color(0xFFB22D00);
    } else if (status == 'In Progress') {
      return const Color(0xFFFF9637);
    } else  {
      return const Color(0xFF2BD066);
    }
  }


  @override
  Widget build(BuildContext context) {
    final borderColor = getBorderColorBasedOnStatus(projectStatus);

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: GestureDetector(
        onTap: (){
          Get.toNamed('/HomePage/HomeOwner/ProjectPage', arguments: {'projectId': projectId});
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 25 , right: 25 , top: 25),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF6781A6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
                width: 2.0,
              ),
            ),
            child: Text(projectName,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFF3D69B)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
