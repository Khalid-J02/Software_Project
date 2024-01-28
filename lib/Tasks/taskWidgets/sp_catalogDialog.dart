import 'package:buildnex/Widgets/TextField.dart';
import 'package:buildnex/Tasks/taskWidgets/catalogDialogItem.dart';
import 'package:flutter/material.dart';
import 'package:buildnex/APIRequests/homePageHomeOwnerAPI.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Widgets/customAlertDialog.dart';
import '../../classes/language_constants.dart';

class CatalogDialogSP extends StatefulWidget {
  Map<String, dynamic> itemDetails ;

  CatalogDialogSP({super.key , required this.itemDetails});

  @override
  State<CatalogDialogSP> createState() => _CatalogDialogSPState();
}

class _CatalogDialogSPState extends State<CatalogDialogSP> {


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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: SingleChildScrollView(
        child: Container(
          height: 430,
          width: 400,
          child: Column(
            children: <Widget>[
               Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  translation(context)!.sp_task10ItemDialog,
                  style: const TextStyle(fontSize: 20, color: Color(0xFFF3D69B)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                height: 250,
                width: 250,
                child: Card(
                  shape:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent, width: 1)
                  ),
                  shadowColor: const Color(0xff26364b),

                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)) ,
                    child: Image(
                      image: NetworkImage(widget.itemDetails['ItemImage']),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.itemDetails['ItemName'],
                    style: TextStyle(fontSize: 22, color: Color(0xFFF3D69B))
                  ),
                  Text("  #${widget.itemDetails['CatalogID']}" , style: TextStyle(fontSize: 22, color: Color(0xFFF3D69B)))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: RatingBarIndicator(
                  rating: widget.itemDetails['ItemRating'].toDouble(),
                  itemSize: 18,
                  unratedColor: Colors.grey,
                  itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFFF3D69B),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
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
                        child:  Text(
                          translation(context)!.sp_task10ItemDialogClose,
                          style:  const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
