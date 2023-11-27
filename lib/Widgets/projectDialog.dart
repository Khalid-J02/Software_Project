import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';


class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final _projectNameController = TextEditingController();
  final _projectStreetLocationController = TextEditingController();

  final _projectNamehint = "Enter Project Name";
  final _projectStreetLocationhint = "Enter Project Location";

  final _projectNamelabel = "Project Name";
  final _projectStreetlabel = "Project Address";

  String _projectCity = "Project City";
  String _projectEntryPoint = "Entry Point";

  ButtonStyle ElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center
    );
  }

  TextStyle ElevatedButtonTextStyle() {
    return TextStyle(
        color: Color(0xFFF3D69B),
        fontSize: 16,
        fontWeight: FontWeight.normal
    );
  }

  void chooseCityBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xFF2F4771),
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Nablus";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Nablus", style: ElevatedButtonTextStyle(),),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Ramallah";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Ramallah", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Tulkarm";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Tulkarm", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Qalqilya";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Qalqilya", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Jenin";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jenin", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _projectCity = "Jericho";
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButtonStyle(),
                      child: Text("Jericho", style: ElevatedButtonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void chooseProjectEntryPoint() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 4,
            color: Color(0xFF2F4771),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _projectEntryPoint = "From Scratch";
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "From Scratch", style: ElevatedButtonTextStyle(),),
                  ),
                  const VerticalDivider(
                    color: Color(0xFFF3D69B),
                    thickness: 1,
                    indent: 10,
                  ),

                  ElevatedButton(
                    style: ElevatedButtonStyle(),
                    onPressed: () {
                      setState(() {
                        _projectEntryPoint = "From Middle";
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                        "From Middle", style: ElevatedButtonTextStyle()),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: Container(
        height: 400,
        width: 300,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Add a New Project:",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFF3D69B)
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
              child: Textfield(controller: _projectNameController,
                  hintText: _projectNamehint,
                  labelText: _projectNamelabel),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
              child: Container(
                width: 270,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: chooseCityBottomSheet,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xFF6781A6)),
                      elevation: MaterialStateProperty.all(0),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFFF3D69B), width: 1)),
                      alignment: Alignment.centerLeft
                  ),
                  child: Text(_projectCity,
                    style: const TextStyle(
                        color: Color(0xFFF3D69B),
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
              child: Textfield(controller: _projectStreetLocationController,
                  hintText: _projectStreetLocationhint,
                  labelText: _projectStreetlabel),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 12.0),
              child: Container(
                width: 270,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: chooseProjectEntryPoint,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xFF6781A6)),
                      elevation: MaterialStateProperty.all(0),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFFF3D69B), width: 1)),
                      alignment: Alignment.centerLeft
                  ),
                  child: Text(_projectEntryPoint,
                    style: const TextStyle(
                        color: Color(0xFFF3D69B),
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3D69B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (isProjectDataValid()) {
                          String? projectId = await _saveProjectData();
                          Navigator.of(context).pop({
                            'projectName': _projectNameController.text,
                            'projectId': projectId
                          });
                        } else {
                          Navigator.of(context).pop(null);
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3D69B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Functions from Tala
  bool isProjectDataValid() {
    return _projectNameController.text != "Project Name" &&
        _projectStreetLocationController.text != "Project Address" &&
        _projectCity != "Project City" &&
        _projectEntryPoint != "Entry Point";
  }

  Future<String?> _saveProjectData() async {
    try {
      // Get the values from the text controllers
      String projectName = _projectNameController.text;
      String projectLocation = _projectStreetLocationController.text;

      // Call the API to add a new project and get the project ID
      String? projectId = await HomeOwnerHomePageAPI.addNewProject(
        projectName: projectName,
        projectCity: _projectCity,
        projectLocation: projectLocation,
        projectEntryPoint: _projectEntryPoint,
      );

      // Check if the project ID is available
      if (projectId != null) {
        // You can use the project ID as needed
        print('Project added successfully. Project ID: $projectId');
        return projectId; // Return the project ID
      } else {
        // Handle the case where the project ID is null (API call failed)
        print('Failed to add a new project');
        return null;
      }
    } catch (error) {
      // Handle API call error
      print('Error adding a new project: $error');
      return null;
    }
  }
}