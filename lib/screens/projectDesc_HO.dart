import 'package:buildnex/Widgets/projectData.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../APIRequests/NavbarProjectPageHomeOwnerAPI.dart';

class ProjectDescription extends StatefulWidget {
  final String projectId;

  const ProjectDescription({
    Key? key,
    required this.projectId,
  }) : super(key: key);

  @override
  State<ProjectDescription> createState() => _ProjectDescriptionState();
}

class _ProjectDescriptionState extends State<ProjectDescription> {
  Map<String, dynamic> projectData = {};

  @override
  void initState() {
    super.initState();
    fetchProjectInformation(widget.projectId);
  }

  void translateStatusToArabic(Map<String, dynamic> list){
    if(list["projectStatus"]! == 'Not Started'){
        list["projectStatus"] = 'لم يبدأ' ;
    }
    else if(list["projectStatus"]! == 'In Progress'){
        list["projectStatus"] = 'قيد التنفيذ' ;
    }
    else{
        list["projectStatus"] = 'مكتمل' ;
      }

  }
  void translateCityToArabic(Map<String, dynamic> list){
    if(list["projectCity"]! == 'Nablus'){
      list["projectCity"] = 'نابلس' ;
    }
    else if(list["projectCity"]! == 'Ramallah'){
      list["projectCity"] = 'رام الله' ;
    }
    else if(list["projectCity"]! == 'Tulkarm'){
      list["projectCity"] = 'طولكرم' ;
    }
    else if(list["projectCity"]! == 'Qalqilya'){
      list["projectCity"] = 'قلقيلية' ;
    }
    else if(list["projectCity"]! == 'Jenin'){
      list["projectCity"] = 'جنين' ;
    }
    else if(list["projectCity"]! == 'Jericho'){
      list["projectCity"] = 'أريحا' ;
    }

  }


  Future<void> fetchProjectInformation(String projectId) async {
    try {
      final fetchedProjectData =
          await HomeOwnerProjectPageNavbarAPI.getProjectInformation(projectId);
      setState(() {
        projectData = fetchedProjectData;
      });
      if(translation(context)!.localeName == 'ar'){
        translateStatusToArabic(projectData) ;
        translateCityToArabic(projectData) ;
      }
    } catch (e) {
      // Handle errors
      print('Error fetching project information: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
                            horizontal: 15, vertical: 30),
                        //child: const Icon(Icons.edit, color: Color(0xFFF3D69B),),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        color: const Color(0xFF2F4771),
                        width: MediaQuery.of(context).size.width,
                        child: ProjectData(
                          projectName: projectData['projectName'] ?? '',
                          projectOwner: projectData['ownerUserName'] ?? '',
                          projectCity: projectData['projectCity'] ?? '',
                          projectLocation: projectData['projectLocation'] ?? '',
                          basinNumber: projectData['BasinNumber'] ?? '',
                          plotNumber: projectData['PlotNumber'] ?? '',
                          projectStatus: projectData['projectStatus'] ?? '',
                          projectProgress: (projectData['projectProgress'])?.toDouble() ?? 0.0,
                          projectBuildArea: projectData['buildingArea']?.toDouble(),
                          projectRoomsNumber: projectData['numberOfRooms'] as int? ,
                          projectFloorNumber: projectData['numberOfFloors'] as int?,
                          projectDesignDocument: projectData['designDocument'],
                          // projectDesignDocument: projectData['designDocument'] as String?,
                          // projectArchStyle: projectData['architecturalStyle'] as String?,
                          // projectDoorMaterial: projectData['doorMaterial'] as String?,
                          // projectDoorColor: projectData['doorColor'] as String?,
                          // projectDoorDesign: projectData['doorDesign'] as String?,
                          // projectTileType: projectData['tileType'] as String?,
                          // projectTileColor: projectData['tileColor'] as String?,
                          // projectTileSize: projectData['tileSize'] as String?,
                          // projectTilePattern: projectData['tilePattern'] as String?,
                          // projectPaintType: projectData['paintType'] as String?,
                          // projectPaintColor: projectData['paintColor'] as String?,
                          // projectPaintFinish: projectData['paintFinish'] as String?,
                          // projectWindowType: projectData['windowType'] as String?,
                          // projectWindowColor: projectData['windowColor'] as String?,
                          // projectWindowDesign: projectData['windowDesign'] as String?,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width > 930
                    ? MediaQuery.of(context).size.width / 120
                    : MediaQuery.of(context).size.width / 40,
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
                        percent: (double.tryParse(projectData['projectProgress'].toString()) ?? 0.0) / 100,
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
                                Icons.house,
                                size: 60,
                                color: Color(0xFFF3D69B),
                              ),
                              Text(
                                '${(double.tryParse(projectData['projectProgress'].toString()) ?? 0.0) }%',
                                style: const TextStyle(
                                    color: Color(0xFFF3D69B),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
