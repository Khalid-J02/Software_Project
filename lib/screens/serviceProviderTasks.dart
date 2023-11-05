import 'package:flutter/material.dart';

import '../Widgets/sp_TaskDetails.dart';

class ServiceProviderTasks extends StatefulWidget {
  const ServiceProviderTasks({super.key});

  @override
  State<ServiceProviderTasks> createState() => _ServiceProviderTasksState();
}

class _ServiceProviderTasksState extends State<ServiceProviderTasks> {

  List serviceProviderTasks_projectName = [
    "Nablus Project",
    "Mall Project",
    "New Project",
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF2F4771),
          child: ListView.builder(
            itemCount: serviceProviderTasks_projectName.length,
            itemBuilder: (context, index) {
              return SPTasksDetails(taskProjectName: serviceProviderTasks_projectName[index], taskProjectOwner: 'Unknown', taskStatus: 'Not Started',) ;
              // return ProjectTasks(taskName: userProjectTasks[index], taskStatus: 'Not Started');
            },
          ),
        ),
      ),
    );
  }
}
