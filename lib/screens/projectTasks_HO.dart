import 'package:buildnex/Widgets/ProjectTasks.dart';
import 'package:flutter/material.dart';


class ProjectTasksHomeOwner extends StatefulWidget {

  const ProjectTasksHomeOwner(
      {
        super.key,
      }
      );

  @override
  State<ProjectTasksHomeOwner> createState() => _ProjectTasksHomeOwnerState();
}

class _ProjectTasksHomeOwnerState extends State<ProjectTasksHomeOwner> {


  List userProjectTasks = [
    "Property Survey",
    "Governmental Permitting",
    "Soil Testing",
    "Design and Planning",
    "Engineers-Municipality Permits and Obligations",
    "Foundation Construction & Structural Framing",
    "Plumbing Installation",
    "Electrical Installation",
    "Insulation and HVAC Installation",
    "Plastering",
    "Door Frame Installation",
    "Tile Installation",
    "Painting",
    "Window Installation",
    "Handover Of The Keys"
  ];

  // Future <String?> addNewProject()=> showDialog <String>(
  //     context: context,
  //     builder: (BuildContext context){
  //       return ProjectDialog();
  //     }
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFF2F4771),
            child: ListView.builder(
              itemCount: userProjectTasks.length,
              itemBuilder: (context, index) {
                return ProjectTasks(taskName: userProjectTasks[index], taskStatus: 'Not Started');
              },
            ),
          ),
        ),
      ),
    );
  }
}
