import 'package:flutter/material.dart';

import '../Widgets/sp_RequestsDetails.dart';

class ServiceProviderRequests extends StatefulWidget {
  const ServiceProviderRequests({super.key});

  @override
  State<ServiceProviderRequests> createState() => _ServiceProviderRequestsState();
}

class _ServiceProviderRequestsState extends State<ServiceProviderRequests> {

  List serviceProviderRequests_projectName = [
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
            itemCount: serviceProviderRequests_projectName.length,
            itemBuilder: (context, index) {
              return SPRequestDetails(taskProjectName: serviceProviderRequests_projectName[index], taskName: 'Window Installation',) ;
              // return SPTasksDetails(taskProjectName: serviceProviderTasks_projectName[index], taskProjectOwner: 'Unknown', taskStatus: 'Not Started',) ;
              // return ProjectTasks(taskName: userProjectTasks[index], taskStatus: 'Not Started');
            },
          ),
        ),
      ),
    );
  }
}
