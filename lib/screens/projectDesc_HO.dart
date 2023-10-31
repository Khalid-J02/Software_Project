import 'package:buildnex/Widgets/projectData.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProjectDescription extends StatefulWidget {
  const ProjectDescription({super.key});

  @override
  State<ProjectDescription> createState() => _ProjectDescriptionState();
}

class _ProjectDescriptionState extends State<ProjectDescription> {
  @override
  Widget build(BuildContext context) {
    String projectName = 'Nablus Project';
    String projectOwner = 'Khalid Ahmad Jabr';
    String projectStatus = 'Not Started';
    String projectCity = 'Nablus';
    String projectLocation = 'Qusin';
    double projectProgress = 0.65;
    double? projectBuildArea = 160;
    int? projectRoomsNumber = 4;
    int? projectFloorNumber = 1;
    String? projectDesignDocument = "PDF File" ;
    String? projectArchStyle ;
    String? projectDoorMaterial ;
    String? projectDoorColor ;
    String? projectDoorDesign ;
    String? projectTileType ;
    String? projectTileColor ;
    String? projectTileSize ;
    String? projectTilePattern ;
    String? projectPaintType;
    String? projectPaintColor ;
    String? projectPaintFinish ;
    String? projectWindowType ;
    String? projectWindowColor ;
    String? projectWindowDesign ;


    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: const Color(0xFF122247),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        //child: const Icon(Icons.edit, color: Color(0xFFF3D69B),),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        color: const Color(0xFF2F4771),
                        width: MediaQuery.of(context).size.width,
                        child: ProjectData(
                          projectName: projectName,
                          projectOwner: projectOwner,
                          projectCity: projectCity,
                          projectLocation: projectLocation,
                          projectStatus: projectStatus,
                          projectProgress: projectProgress,
                          projectBuildArea: projectBuildArea,
                          projectRoomsNumber: projectRoomsNumber,
                          projectFloorNumber: projectFloorNumber,
                          projectDesignDocument: projectDesignDocument,
                          projectArchStyle : projectArchStyle,
                          projectDoorMaterial :projectDoorMaterial,
                          projectDoorColor :projectDoorColor,
                          projectDoorDesign :projectDoorDesign,
                          projectTileType :projectTileType,
                          projectTileColor :projectTileColor,
                          projectTileSize :projectTileSize,
                          projectTilePattern :projectTilePattern,
                          projectPaintType:projectPaintType,
                          projectPaintColor :projectPaintColor,
                          projectPaintFinish :projectPaintFinish,
                          projectWindowType :projectWindowType,
                          projectWindowColor :projectWindowColor,
                          projectWindowDesign :projectWindowDesign,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width / 40,
                  left: MediaQuery.of(context).size.width / 3,
                  right: MediaQuery.of(context).size.width / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFF3D69B),
                        width: 5,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1200,
                      radius: 69,
                      lineWidth: 10,
                      percent: projectProgress,
                      progressColor: Color(0xFFEEAF2F),
                      backgroundColor: Color(0xFFEAD6AC),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF2F4771),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Icon(
                              Icons.house ,
                              size: 60 ,
                              color: Color(0xFFF3D69B),
                            ),
                            Text('${projectProgress * 100}%',
                              style: const TextStyle(
                                  color: Color(0xFFF3D69B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
