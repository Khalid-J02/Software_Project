import 'package:buildnex/screens/searchPage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectTasks extends StatelessWidget {
  final String taskID;
  final String taskName;
  final String taskStatus;
  final String? serviceProviderID;
  final String? serviceProviderName;

  const ProjectTasks({
    Key? key,
    required this.taskID,
    required this.taskName,
    required this.taskStatus,
    this.serviceProviderID,
    this.serviceProviderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF6781A6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFF3D69B),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Text(
                    taskName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF3D69B),
                    ),
                  ),
                ),
                const Expanded(
                  /*
                  Here you should pass the description for the task, to test it you should
                  keep pressing the info icon in the top right
                   */
                  flex: 1,
                  child: Tooltip(
                    message: "Here Will Go the Description of the task",
                    padding: EdgeInsets.all(12),
                    showDuration: Duration(seconds: 10),
                    textStyle: TextStyle(color: Colors.white),
                    decoration: BoxDecoration(
                      color: Color(0xFF122247)
                    ),
                    preferBelow: false,
                    verticalOffset: 10,
                    child: Icon(
                      Icons.info,
                      color: Color(0xFFF3D69B),
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Color(0xFFF9FAFB),
                    size: 18,
                  ),
                  Text(
                    " $taskStatus",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFF9FAFB),
                    ),
                  ),
                ],
              ),
            ),
            if (serviceProviderName != 'No Provider Name')
              Container(
                height: 48,
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          color: Color(0xFFF9FAFB),
                          size: 18,
                        ),
                        Text(
                          " $serviceProviderName",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFF9FAFB),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3D69B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: TextButton(
                        onPressed: () {
                          // here you will move to tasks like task1 2 3 etc
                          Navigator.pushNamed(
                            context,
                            '/next_screen',
                            arguments: {
                              'taskID': taskID,
                              'serviceProviderID': serviceProviderID,
                            },
                          );
                        },
                        child: const Text(
                          "Open Task",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3D69B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 5, top: 5),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to the next screen and pass taskID and serviceProviderID
                        Get.to(SearchPage(askForRequest: true,),) ;
                      },
                      child: const Text(
                        "Add Provider",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF122247),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
