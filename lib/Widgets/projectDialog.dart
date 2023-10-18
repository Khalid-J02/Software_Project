import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';


class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final _projectNameController = TextEditingController();
  final _projectStreetLocationController = TextEditingController();

  final _projectNamehint = "Enter Project Name";
  final _projectStreetLocationhint = "Enter Project Location";

  final _projectNamelabel = "Project Name";
  final _projectStreetlabel = "Project Address";

  String _projectCity = "Project City";
  String _projectEntryPoint = "Entry Point";

  void chooseCityBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SizedBox(
            height: 350,
            child: Center(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                  onPressed: (){
                    setState(() {
                      _projectCity = "Nablus" ;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Nablus"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectCity = "Ramallah" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Ramallah"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectCity = "Tulkarm" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Tulkarm"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectCity = "Qalqilya" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Qalqilya"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectCity = "Jenin" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Jenin"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectCity = "Jericho" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Jericho"),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void chooseProjectEntryPoint(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SizedBox(
            height: 350,
            child: Center(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectEntryPoint = "From Scratch" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("From Scratch"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _projectEntryPoint = "From Middle" ;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("From Middle"),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFabcdd2),
      content: Container(
        height: 400,
        width: 300,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Add a New Project:",
              style: TextStyle(
                fontSize: 20
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
              child: Textfield(controller: _projectNameController, hintText: _projectNamehint, labelText: _projectNamelabel),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
              child: Container(
                width: 270,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: chooseCityBottomSheet,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFFcce2e6)),
                    elevation: MaterialStateProperty.all(0),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.black, width: 1)),
                    alignment: Alignment.centerLeft
                  ),
                  child: Text(_projectCity,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal
                  ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
              child: Textfield(controller: _projectStreetLocationController, hintText: _projectStreetLocationhint, labelText: _projectStreetlabel),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
              child: Container(
                width: 270,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: chooseProjectEntryPoint,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFcce2e6)),
                      elevation: MaterialStateProperty.all(0),
                      side: MaterialStateProperty.all(BorderSide(color: Colors.black, width: 1)),
                      alignment: Alignment.centerLeft
                  ),
                  child: Text(_projectEntryPoint,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top : 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF42747B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(_projectNameController.text);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Color(0xFF42747B),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
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
    );
  }
}



