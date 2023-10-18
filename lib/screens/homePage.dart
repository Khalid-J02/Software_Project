
import 'package:buildnex/Widgets/projectDialog.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/Widgets/userProjects.dart';

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

  List usersProject = [
    "Nablus Project",
    "Home Project"
  ];

  // create new project
  Future <String?> addNewProject()=> showDialog <String>(
        context: context,
        builder: (BuildContext context){
          return ProjectDialog();
        }
    );



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, //#abcdd2 chose this color instead

        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF42747B),
          onPressed: () async {
            String? newProject = await addNewProject();
            setState(() {
              if(newProject != null){
                usersProject.add(newProject);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: Icon(Icons.house_outlined),
          title: const Text(
            'Your Projects',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/Profile Icon.png'), // add gesturewidget on tap function
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Color(0xFF42747B),//Colors.white,
        ),

        body: SafeArea(
          child: Container(
            color: Color(0xFFabcdd2), // 0xFF42747B
            child: ListView.builder(
              itemCount: usersProject.length,
              itemBuilder: (context, index) {
                return UserProjects(projectName: usersProject[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
