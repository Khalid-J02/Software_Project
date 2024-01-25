import 'package:buildnex/Widgets/projectDataAccordian.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';

class ProjectData extends StatefulWidget {
  String projectName;
  String projectOwner;
  String projectStatus;
  String projectCity;
  String projectLocation;
  String basinNumber;
  String plotNumber;
  double projectProgress;
  double? projectBuildArea;
  int? projectRoomsNumber;
  int? projectFloorNumber;
  String? projectDesignDocument;
  String? projectArchStyle;
  String? projectDoorMaterial;
  String? projectDoorColor;
  String? projectDoorDesign;
  String? projectTileType;
  String? projectTileColor;
  String? projectTileSize;
  String? projectTilePattern;
  String? projectPaintType;
  String? projectPaintColor;
  String? projectPaintFinish;
  String? projectWindowType;
  String? projectWindowColor;
  String? projectWindowDesign;

  ProjectData({
    super.key,
    required this.projectName,
    required this.projectOwner,
    required this.projectStatus,
    required this.projectCity,
    required this.projectLocation,
    required this.basinNumber,
    required this.plotNumber,
    required this.projectProgress,
    this.projectBuildArea,
    this.projectRoomsNumber,
    this.projectFloorNumber,
    this.projectDesignDocument,
    this.projectArchStyle,
    this.projectDoorMaterial,
    this.projectDoorColor,
    this.projectDoorDesign,
    this.projectTileType,
    this.projectTileColor,
    this.projectTileSize,
    this.projectTilePattern,
    this.projectPaintType,
    this.projectPaintColor,
    this.projectPaintFinish,
    this.projectWindowType,
    this.projectWindowColor,
    this.projectWindowDesign,
  });

  @override
  State<ProjectData> createState() => _ProjectDataState();
}

class _ProjectDataState extends State<ProjectData> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Text(
              widget.projectName,
              style: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translation(context)!.homeOwnerProjectDataOwnedBy,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.projectOwner,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translation(context)!.homeOwnerProjectDataStatus,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.projectStatus,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.homeOwnerProjectDataCity,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.projectCity,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.homeOwnerProjectDataAddress,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.projectLocation,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.homeOwnerProjectDataBasinNumber,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.basinNumber,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.homeOwnerProjectDataPlotNumber,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.plotNumber,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 15, right: 20, left: 20, bottom: 0),
                child: MainProjectDataAccordion(
                  projectBuildArea: widget.projectBuildArea,
                  projectRoomsNumber: widget.projectRoomsNumber,
                  projectFloorNumber: widget.projectFloorNumber,
                  projectDesignDocument: widget.projectDesignDocument,
                  // projectArchStyle: widget.projectArchStyle,
                  // projectDoorColor: widget.projectDoorColor,
                  // projectDoorDesign: widget.projectDoorDesign,
                  // projectDoorMaterial: widget.projectDoorMaterial,
                  // projectPaintColor: widget.projectPaintColor,
                  // projectPaintFinish: widget.projectPaintFinish,
                  // projectPaintType: widget.projectPaintType,
                  // projectTileColor: widget.projectTileColor,
                  // projectTilePattern: widget.projectTilePattern,
                  // projectTileSize: widget.projectTileSize,
                  // projectTileType: widget.projectTileType,
                  // projectWindowColor: widget.projectWindowColor,
                  // projectWindowDesign: widget.projectWindowDesign,
                  // projectWindowType: widget.projectWindowType,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
