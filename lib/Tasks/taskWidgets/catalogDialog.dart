import 'package:buildnex/Widgets/TextField.dart';
import 'package:buildnex/Tasks/taskWidgets/catalogDialogItem.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';

import '../../Widgets/customAlertDialog.dart';

class CatalogDialog extends StatefulWidget {
  const CatalogDialog({super.key});

  @override
  State<CatalogDialog> createState() => _CatalogDialogState();
}

class _CatalogDialogState extends State<CatalogDialog> {


  ButtonStyle ElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFFF3D69B), width: 1)),
        alignment: Alignment.center);
  }

  TextStyle ElevatedButtonTextStyle() {
    return TextStyle(
        color: Color(0xFFF3D69B), fontSize: 16, fontWeight: FontWeight.normal);
  }

  List<Map<String, dynamic>> serviceProviderCatalog = [
    {
      "Name" : "Ex1",
      "image" : "images/Testing/Iceland.jpg",
      "rating": 3.2
    },
    {
      "Name" : "Ex2",
      "image" : "images/Testing/Iceland.jpg",
      "rating": 2.9
    },
    {
      "Name" : "Ex3",
      "image" : "images/Testing/Iceland.jpg",
      "rating": 3.9
    },
    {
      "Name" : "Ex4",
      "image" : "images/Testing/Iceland.jpg",
      "rating": 4.3
    },
    {
      "Name" : "Ex5",
      "image" : "images/Testing/Iceland.jpg",
      "rating": 4.3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: SingleChildScrollView(
        child: Container(
          height: 500,
          width: 400,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Choose From Following:",
                  style: TextStyle(fontSize: 20, color: Color(0xFFF3D69B)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: serviceProviderCatalog.length,
                  itemBuilder: (context, index) {
                    return CatalogDialogItem(
                      itemName: serviceProviderCatalog[index]["Name"],
                      itemImage: serviceProviderCatalog[index]["image"],
                      itemRating: serviceProviderCatalog[index]["rating"],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          // if (isProjectDataValid()) {
                          //   String? projectId = await _saveProjectData();
                          //   Navigator.of(context).pop({
                          //     'projectName': _projectNameController.text,
                          //     'projectId': projectId
                          //   });
                          // } else {
                          //   Navigator.of(context).pop(null);
                          //   CustomAlertDialog.showErrorDialog(
                          //       context, 'Please fill in all the fields');
                          // }

                          /*
                          here we should return the item id so modify it, and save it.
                           */
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
                      margin: EdgeInsets.only(top: 10),
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
      ),
    );
  }

  //Functions from Tala
  // bool isProjectDataValid() {
  //   return _projectNameController.text.isNotEmpty &&
  //       _projectStreetLocationController.text.isNotEmpty &&
  //       _projectCity != "Construction City" &&
  //       _projectEntryPoint != "Entry Point" &&
  //       _basinNumberController.text.isNotEmpty &&
  //       _plotNumberController.text.isNotEmpty;
  // }
  // Future<String?> _saveProjectData() async {
  //   try {
  //     // Get the values from the text controllers
  //     String projectName = _projectNameController.text;
  //     String projectLocation = _projectStreetLocationController.text;
  //
  //     // Call the API to add a new project and get the project ID
  //     String? projectId = await HomeOwnerHomePageAPI.addNewProject(
  //       projectName: projectName,
  //       projectCity: _projectCity,
  //       projectLocation: projectLocation,
  //       projectEntryPoint: _projectEntryPoint,
  //     );
  //
  //     // Check if the project ID is available
  //     if (projectId != null) {
  //       // You can use the project ID as needed
  //       print('Project added successfully. Project ID: $projectId');
  //       return projectId; // Return the project ID
  //     } else {
  //       // Handle the case where the project ID is null (API call failed)
  //       print('Failed to add a new project');
  //       return null;
  //     }
  //   } catch (error) {
  //     // Handle API call error
  //     print('Error adding a new project: $error');
  //     return null;
  //   }
  // }

}
