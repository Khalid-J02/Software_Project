
import 'package:flutter/material.dart';

import '../APIRequests/serviceProviderTasksAPI.dart';
import '../Widgets/sp_TaskDetails.dart';

class ServiceProviderTasks extends StatefulWidget {
  const ServiceProviderTasks({super.key});

  @override
  State<ServiceProviderTasks> createState() => _ServiceProviderTasksState();
}

class _ServiceProviderTasksState extends State<ServiceProviderTasks> {

  List<Map<String, dynamic>> serviceProviderTasks = [];

  @override
  void initState() {
    super.initState();
    // Call the API to fetch service provider projects when the widget is initialized
    fetchServiceProviderProjects();
  }

  Future<void> fetchServiceProviderProjects() async {
    try {
      // Fetch service provider projects using the API client
      final List<Map<String, dynamic>> projects = await ServiceProviderProjectsAPI.getServiceProviderProjects();

      // Update the state with the fetched projects
      setState(() {
        serviceProviderTasks = projects;
      });
    } catch (e) {
      // Handle any errors or exceptions during the API call
      print('Error fetching service provider projects: $e');
      // You might want to show an error message to the user
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF2F4771),
          child: ListView.builder(
            itemCount: serviceProviderTasks.length,
            itemBuilder: (context, index) {
              final task = serviceProviderTasks[index];
              return SPTasksDetails(
                taskProjectName:  task['projectName'] ?? 'Unknown',
                taskProjectOwner: task['homeOwnerName'] ??'Unknown',
                taskProjectId: task['projectID'].toString(),
                taskStatus: task['taskStatus'] ?? 'Unknown',
                taskID: task['taskId'].toString() ?? 'Unknown',
                taskNumber: task['taskNumber'].toString() ?? 'Unknown',
              );
            },
          ),
        ),
      ),
    );
  }
}