import 'package:buildnex/Widgets/ProjectTasks.dart';
import 'package:flutter/material.dart';

import '../APIRequests/NavbarProjectPageHomeOwnerAPI.dart';

class ProjectTasksHomeOwner extends StatefulWidget {
  final String projectId;

  const ProjectTasksHomeOwner({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  State<ProjectTasksHomeOwner> createState() => _ProjectTasksHomeOwnerState();
}

class _ProjectTasksHomeOwnerState extends State<ProjectTasksHomeOwner> {
  List<Map<String, dynamic>> userProjectTasks = [];
  bool isLoading = true; // Track whether tasks are being loaded

  @override
  void initState() {
    super.initState();
    fetchTasks(widget.projectId);
  }

  Future<void> fetchTasks(String projectId) async {
    try {
      final fetchedTasks =
      await HomeOwnerProjectPageNavbarAPI.getProjectTasks(projectId);

      setState(() {
        userProjectTasks = fetchedTasks;
        isLoading = false; // Set loading to false when tasks are loaded
        print('userProjectTasks: $userProjectTasks');
      });
    } catch (e) {
      // Handle errors
      print('Error fetching tasks: $e');
      setState(() {
        isLoading = false; // Set loading to false even in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xFF2F4771),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: userProjectTasks.length,
              itemBuilder: (context, index) {
                return ProjectTasks(
                  taskID: userProjectTasks[index]["TaskID"].toString(),
                  taskName: userProjectTasks[index]["TaskName"]!,
                  taskStatus: userProjectTasks[index]["TaskStatus"]!,
                  serviceProviderID: userProjectTasks[index]["ServiceProviderID"]?.toString() ?? 'No Provider ID',
                  serviceProviderName:  userProjectTasks[index]["ServiceProviderName"] != null
                      ? (userProjectTasks[index]["ServiceProviderName"] is Map
                      ? userProjectTasks[index]["ServiceProviderName"]!['Username'].toString()
                      : userProjectTasks[index]["ServiceProviderName"]!.toString())
                      : 'No Provider Name',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
