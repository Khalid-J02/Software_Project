import 'package:flutter/material.dart';

class TaskInformation extends StatefulWidget {
  int taskID ;
  String taskName ;
  String projectName ;
  String taskStatus ;

  TaskInformation(
      {
        super.key,
        required this.taskID,
        required this.taskName,
        required this.projectName,
        required this.taskStatus
      }
  );

  @override
  State<TaskInformation> createState() => _TaskInformationState();
}

class _TaskInformationState extends State<TaskInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.zero,
          topLeft: Radius.zero,
        ),
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
              height: MediaQuery.of(context).size.height/17 ,
              // color: Color(0xFF6781A6),
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
                  "Task #${widget.taskID}",
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.107843137 + 10,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(
                                "Task",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(
                                "Project",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(
                                "Status",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                          child: Text(
                            widget.taskName,
                            style: const TextStyle(
                              color: Color(0xFF2F4771),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ),
                        Expanded(
                          child: Text(
                            widget.projectName,
                            style: const TextStyle(
                                color: Color(0xFF2F4771),
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.taskStatus,
                            style: const TextStyle(
                                color: Color(0xFF2F4771),
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3,),
          ],
        ),
      ),
    );
  }
}
