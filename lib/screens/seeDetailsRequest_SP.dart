import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../APIRequests/serviceProviderRequestsAPI.dart';
import '../Widgets/ProjectDataDetails.dart';

class ProjectDescriptionSeeDetails extends StatefulWidget {
  final String projectId;
  final String taskId;

  const ProjectDescriptionSeeDetails({
    Key? key,
    required this.projectId,
    required this.taskId,
  }) : super(key: key);

  @override
  State<ProjectDescriptionSeeDetails> createState() => _ProjectDescriptionSeeDetailsState();
}

class _ProjectDescriptionSeeDetailsState extends State<ProjectDescriptionSeeDetails> {
  bool _isLoading = true;
  Map<String, dynamic> projectData = {};

  @override
  void initState() {
    super.initState();
    fetchProjectInformation();
  }

  Future<void> fetchProjectInformation() async {
    try {
      final fetchedProjectData = await RequestsAPI.getProjectDetails(widget.projectId, widget.taskId);
      setState(() {
        projectData = fetchedProjectData;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      print('Error fetching project information: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height/1.25,
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
                    flex: 6,
                    child: Container(
                      color: const Color(0xFF2F4771),
                      width: MediaQuery.of(context).size.width,
                      child: ProjectDataDetails(
                        projectName: projectData['projectName'] ?? '',
                        projectOwner: projectData['ownerUserName'] ?? '',
                        projectCity: projectData['projectCity'] ?? '',
                        projectLocation: projectData['projectLocation'] ?? '',
                        taskDescription: projectData['taskDescription'] ?? '',
                        taskName: projectData['taskName'] ?? '',
                        taskDate: projectData['taskDate'] ?? '',
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
                      percent: 1.0,
                      progressColor: Color(0xFFEEAF2F),
                      backgroundColor: Color(0xFFEAD6AC),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF2F4771),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.house,
                              size: 60,
                              color: Color(0xFFF3D69B),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
