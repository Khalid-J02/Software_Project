import 'package:flutter/material.dart';

class ProjectTasks extends StatelessWidget {

  final String taskName ;
  final String taskStatus ;

   const ProjectTasks(
      {
        super.key,
        required this.taskName,
        required this.taskStatus,
      }
      );

  @override
  Widget build(BuildContext context) {  // edit this shit
    return Padding(
      padding: const EdgeInsets.only(left: 15 , right: 15 , top: 15),
      child: Container(
        //height: MediaQuery.of(context).size.width / 5 ,
        padding: const EdgeInsets.only(top: 10 , left: 15, right: 10),
        decoration: BoxDecoration(
            color: const  Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Color(0xFFF3D69B)
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(taskName,
              style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF3D69B)
              ),
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
                  Text(" $taskStatus",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF9FAFB)
                    ),
                  ),
                ],
              ),
            ),
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
                  margin: const EdgeInsets.only(bottom: 5 , top: 5),
                  child: TextButton(
                      onPressed: (){},
                      child: const Text("Add Provider",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color(0xFF122247)
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
