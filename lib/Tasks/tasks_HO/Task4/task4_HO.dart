import 'package:buildnex/Tasks/taskWidgets/pdfViewer.dart';
import 'package:buildnex/Tasks/taskWidgets/taskInformation.dart';
import 'package:buildnex/Tasks/tasks_HO/LocalGovernorate_Permits/Widgets/serviceProviderProfleData.dart';
import 'package:buildnex/Tasks/tasks_SP/PropertSurvey/widgets/textFieldTasks.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import '../../../APIRequests/homeOwnerTasksAPI.dart';
import '../../../Widgets/customAlertDialog.dart';

void main() {
  runApp(GetMaterialApp(home: DesignAndPlanningHO()));
}

class DesignAndPlanningHO extends StatefulWidget {
  const DesignAndPlanningHO({super.key});

  @override
  State<DesignAndPlanningHO> createState() => _DesignAndPlanningHOState();
}

class _DesignAndPlanningHOState extends State<DesignAndPlanningHO> {
  final _numRooms = TextEditingController();
  final _numFloors = TextEditingController();
  final _buildingArea = TextEditingController();

  Map<String, dynamic> task4Data = {};
  String taskID = '';
  String taskProjectId = '';
  String designDocument = '';
  String foundationDocument = '';
  String plumbingDocument = '';
  String electricalDocument = '';
  String insulationAndHVACDocument = '';
  int? numRooms;
  int? numFloors;
  double? buildingArea;
  double? _progress;

  late Map<String, dynamic> getbuildingData;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> arguments = Get.arguments;
    setState(() {
      taskID = arguments['taskID'];
      taskProjectId = arguments['taskProjectId'];
      task4Data = arguments['DesignData'];
      getbuildingData = arguments['buildingData'];
    });
    fetchArgumentsAndData();
  }

  void fetchArgumentsAndData() async {
    try {
      setState(() {
        numRooms = getbuildingData['NumberOfRooms'] != null
            ? int.tryParse(getbuildingData['NumberOfRooms'].toString())
            : null;

        numFloors = getbuildingData['NumberOfFloors'] != null
            ? int.tryParse(getbuildingData['NumberOfFloors'].toString())
            : null;

        buildingArea = getbuildingData['BuildingArea'] != null
            ? double.tryParse(getbuildingData['BuildingArea'].toString())
            : null;

        if (numRooms != null) {
          _numRooms.text = numRooms.toString();
        }
        if (numFloors != null) {
          _numFloors.text = numFloors.toString();
        }
        if (buildingArea != null) {
          _buildingArea.text = buildingArea.toString();
        }
      });
    } catch (e) {
      print('Error fetching task4 data: $e');
    }
  }

  Future<bool> validateInput() async {
    // Check if the number of rooms is not empty and greater than 0
    if (_numRooms.text.isEmpty || int.tryParse(_numRooms.text)! <= 0) {
      print(_numRooms.text);
      CustomAlertDialog.showErrorDialog(context, 'Invalid number of rooms');
      return false;
    }

    // Check if the number of floors is not empty and greater than 0
    if (_numFloors.text.isEmpty || int.tryParse(_numFloors.text)! <= 0) {
      CustomAlertDialog.showErrorDialog(context, 'Invalid number of floors');
      return false;
    }

    // Check if the building area is not empty and greater than 0
    if (_buildingArea.text.isEmpty ||
        double.tryParse(_buildingArea.text)! <= 0.0) {
      CustomAlertDialog.showErrorDialog(context, 'Invalid building area');
      return false;
    }

    return true;
  }

  void downloadFile(String _docs) {
    FileDownloader.downloadFile(
      url: _docs,
      onProgress: (name, progress) {
        setState(() {
          _progress = _progress;
        });
      },
      onDownloadCompleted: (value) {
        setState(() {
          _progress = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: Text(
              translation(context)!.task1HOMainTitle,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                TaskInformation(
                  taskID: task4Data['TaskID'] ?? 0,
                  taskName: translation(context)!.task4HOTaskName,
                  projectName: task4Data['ProjectName'] ?? 'Unknown',
                  taskStatus: task4Data['TaskStatus'] ?? 'Unknown',
                ),
                SPProfileData(
                  userPicture:
                      task4Data['UserPicture'] ?? 'images/profilePic96.png',
                  rating: (task4Data['Rating'] as num?)?.toDouble() ?? 0.0,
                  numReviews: task4Data['ReviewCount'] ?? 0,
                  userName: task4Data['Username'] ?? 'Unknown',
                  taskId: taskID,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Color(0xFF6781A6),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                              color: Color(0xFF2F4771),
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translation(context)!.task4HODemandsMainTitle,
                              style: const TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Container(
                          padding: const EdgeInsets.all(7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HODemandsNumRoom,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextfieldTasks(
                                      controller: _numRooms,
                                      hintText: translation(context)!.task4HODemandsNumRoomHintText,
                                      labelText: translation(context)!.task4HODemandsNumRoomLabelText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HODemandsNumFloor,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextfieldTasks(
                                      controller: _numFloors,
                                      hintText: translation(context)!.task4HODemandsNumFloorHintText,
                                      labelText: translation(context)!.task4HODemandsNumFloorLabelText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HODemandsBuildingArea,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: TextfieldTasks(
                                      controller: _buildingArea,
                                      hintText: translation(context)!.task4HODemandsBuildingAreaHintText,
                                      labelText: translation(context)!.task4HODemandsBuildingAreaLabelText,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Container(
                                  width: 250,
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2F4771),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (await validateInput()) {
                                        final savedData = await HomeOwnerTasksAPI
                                            .saveBuildingData(
                                                int.parse(taskProjectId),
                                                int.tryParse(_numRooms.text),
                                                int.tryParse(_numFloors.text),
                                                double.tryParse(
                                                    _buildingArea.text));
                                        _numRooms.text =
                                            savedData['NumberOfRooms'].toString();
                                        _numFloors.text =
                                            savedData['NumberOfFloors']
                                                .toString();
                                        _buildingArea.text =
                                            savedData['BuildingArea'].toString();
                                        CustomAlertDialog.showSuccessDialog(
                                            context,
                                            "Building data saved successfully");
                                        return;
                                      }
                                    },
                                    child: Text(
                                      translation(context)!.task4HODemandsSaveButton,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFFF9FAFB),
                                      ),
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
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Color(0xFF6781A6),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                            border: Border.all(
                              color: Color(0xFF2F4771),
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translation(context)!.task1HOServiceProviderDetailsTitle,
                              style: const TextStyle(
                                  color: Color(0xFFF9FAFB),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HODesignDocument,
                                        style: TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (getbuildingData[
                                                    'DesignDocument'] !=
                                                null) {
                                              downloadFile(getbuildingData[
                                                  'DesignDocument']);
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  const EdgeInsets.only(left: 8, right: 8)
                                                      :
                                                  const EdgeInsets.only(left: 8, right: 8),
                                                  child: const Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 12.0)
                                                      :
                                                  const EdgeInsets.only(right: 12.0),
                                                  child: Text(
                                                    translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      if (getbuildingData['DesignDocument'] !=
                                          null) {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL:
                                              getbuildingData['DesignDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar'
                                                ?
                                            const EdgeInsets.only(left: 8, right: 8)
                                                :
                                            const EdgeInsets.only(left: 8, right: 8),
                                            child: const Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 12.0)
                                                :
                                            const EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HODemandsBuildingAreaLabelText, // Foundation became Architectural
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (getbuildingData[
                                                    'FoundationDocument'] !=
                                                null) {
                                              downloadFile(getbuildingData[
                                                  'FoundationDocument']);
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar'
                                                      ?
                                                  const EdgeInsets.only(left: 8, right: 8)
                                                      :
                                                  const EdgeInsets.only(left: 8, right: 8),
                                                  child: const Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 12.0)
                                                      :
                                                  const EdgeInsets.only(right: 12.0),
                                                  child: Text(
                                                    translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      if (getbuildingData['FoundationDocument'] !=
                                          null) {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: getbuildingData[
                                              'FoundationDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 12.0)
                                                :
                                            const EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HOCivilDrawings, // Insulation became For Civil
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (getbuildingData[
                                                    'InsulationAndHVACDocument'] !=
                                                null) {
                                              downloadFile(getbuildingData[
                                                  'InsulationAndHVACDocument']);
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 12.0)
                                                      :
                                                  const EdgeInsets.only(right: 12.0),
                                                  child: Text(
                                                      translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      if (getbuildingData[
                                              'InsulationAndHVACDocument'] !=
                                          null) {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: getbuildingData[
                                              'InsulationAndHVACDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 12.0)
                                                :
                                            const EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HOMechanicalDrawings, // Plumbing became Mechanical
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (getbuildingData[
                                                    'PlumbingDocument'] !=
                                                null) {
                                              downloadFile(getbuildingData[
                                                  'PlumbingDocument']);
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 12.0)
                                                      :
                                                  const EdgeInsets.only(right: 12.0),
                                                  child: Text(
                                                      translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      if (getbuildingData['PlumbingDocument'] !=
                                          null) {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL:
                                              getbuildingData['PlumbingDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 12.0)
                                                :
                                            const EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        translation(context)!.task4HOElectricalDrawings,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  _progress != null
                                      ? const CircularProgressIndicator()
                                      : GestureDetector(
                                          onTap: () {
                                            if (getbuildingData[
                                                    'ElectricalDocument'] !=
                                                null) {
                                              downloadFile(getbuildingData[
                                                  'ElectricalDocument']);
                                            } else {
                                              Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorDownloadMsg) ;
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 5, right: 5),
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2F4771),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Icon(
                                                    Icons.sim_card_download,
                                                    size: 20,
                                                    color: Color(0xFFF9FAFB),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: translation(context)!.localeName == 'ar' ?
                                                  const EdgeInsets.only(left: 12.0)
                                                      :
                                                  const EdgeInsets.only(right: 12.0),
                                                  child: Text(
                                                    translation(context)!.downloadLabelButton,
                                                    style: const TextStyle(
                                                      color: Color(0xFFF9FAFB),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  GestureDetector(
                                    onTap: () {
                                      if (getbuildingData['ElectricalDocument'] !=
                                          null) {
                                        Get.to(DocsPdfViewer(
                                          pdfFileURL: getbuildingData[
                                              'ElectricalDocument'],
                                        ));
                                      } else {
                                        Get.snackbar(translation(context)!.helloMSG, translation(context)!.errorOpenMsg);
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(top: 5, right: 5),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F4771),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.file_open_outlined,
                                              size: 20,
                                              color: Color(0xFFF9FAFB),
                                            ),
                                          ),
                                          Padding(
                                            padding: translation(context)!.localeName == 'ar' ?
                                            const EdgeInsets.only(left: 12.0)
                                                :
                                            const EdgeInsets.only(right: 12.0),
                                            child: Text(
                                              translation(context)!.openLabelButton,
                                              style: const TextStyle(
                                                color: Color(0xFFF9FAFB),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        translation(context)!.task1HOServiceProviderNotes,
                                        style: const TextStyle(
                                            color: Color(0xFF2F4771),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      height: 140,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: TextFormField(
                                        maxLines: 5,
                                        minLines: 5,
                                        enabled: false,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: task4Data['Notes'] ??
                                              translation(context)!.task1HONoNotesSP,
                                          hintStyle:
                                              TextStyle(color: Color(0xFF2F4771)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF2F4771),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF2F4771),
                                              width: 1.5,
                                            ),
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
                      ],
                    ),
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
