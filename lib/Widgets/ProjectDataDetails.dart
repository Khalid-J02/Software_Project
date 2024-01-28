import 'package:flutter/material.dart';

import '../classes/language_constants.dart';

class ProjectDataDetails extends StatefulWidget {
  String projectName;
  String projectOwner;
  String projectCity;
  String projectLocation;
  String taskDescription;
  String taskName;
  String taskDate;

  ProjectDataDetails({
    super.key,
    required this.projectName,
    required this.projectOwner,
    required this.projectCity,
    required this.projectLocation,
    required this.taskDescription,
    required this.taskName,
    required this.taskDate,
  });

  @override
  State<ProjectDataDetails> createState() => _ProjectDataDetailsState();
}

class _ProjectDataDetailsState extends State<ProjectDataDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
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
                  translation(context)!.projectDataDetailsOwned,
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
          Container(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.projectDataDetailsAddress,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.projectLocation,
                    style: const TextStyle(
                        color: Color(0xFFF9FAFB),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.projectDataDetailsTaskName,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.taskName,
                    style: const TextStyle(
                        color: Color(0xFFF9FAFB),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.projectDataDetailsTaskDesc,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.taskDescription,
                    style: const TextStyle(
                        color: Color(0xFFF9FAFB),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  translation(context)!.projectDataDetailsTaskDate,
                  style: const TextStyle(
                      color: Color(0xFFF3D69B),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      widget.taskDate,
                      style: const TextStyle(
                          color: Color(0xFFF9FAFB),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
