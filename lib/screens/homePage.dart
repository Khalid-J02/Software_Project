
import 'package:buildnex/Widgets/projectDialog.dart';
import 'package:buildnex/screens/projectNav_homeOwner.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/Widgets/userProjects.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> usersProject = [];

  @override
  void initState() {
    super.initState();
    // Call the API and update usersProject when the widget is initialized
    updateProjects();
  }


  // create new project
  Future<void> addNewProject() async {
    Map<String, dynamic>? newProject = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return ProjectDialog();
      },
    );

    if (newProject != null) {
      // Update the UI with the new list of projects
      setState(() {
        usersProject.add({
          'projectId': newProject['projectId'],
          'projectName': newProject['projectName'],
          // Add other project details as needed
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.white, //#abcdd2 chose this color instead
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF3D69B),
            onPressed: () async {
              await addNewProject();
            },
          child: const Icon(Icons.add , color: Color(0xFF122247),),
        ),
        appBar: AppBar(
          leading: Icon(Icons.house_outlined , color: Color(0xFFF3D69B),),
          title: const Text(
            'Your Constructions',
            style: TextStyle(
              color: Color(0xFFF3D69B)
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247),//Colors.white,
        ),

        body: SafeArea(
          child: Container(
            color: Color(0xFF2F4771), // 0xFF42747B
            child: ListView.builder(
              itemCount: usersProject.length,
              itemBuilder: (context, index) {
                return UserProjects(
                projectId: usersProject[index]['projectId'].toString(),
                projectName: usersProject[index]['projectName'] ,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //Functions from Tala
  Future<void> updateProjects() async {
    try {
      List<Map<String, dynamic>> projects = await HomeOwnerHomePageAPI.getHomeOwnerProjects();
      setState(() {
        usersProject = projects;
        print('Projects: $projects'); // Print retrieved projects

      });
    } catch (error) {
      print('Error updating projects: $error');
    }
  }
}