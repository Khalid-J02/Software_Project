import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class ServiceProviderProfileDataDialog extends StatefulWidget {

  String phoneNumber ;
  String eMail;
  String bio ;
  int pricePerHour ;

  ServiceProviderProfileDataDialog(
      {
        super.key,
        required this.phoneNumber,
        required this.eMail,
        required this.bio,
        required this.pricePerHour
      });

  @override
  State<ServiceProviderProfileDataDialog> createState() => _ServiceProviderProfileDataDialogState();
}

class _ServiceProviderProfileDataDialogState extends State<ServiceProviderProfileDataDialog> {

  final _userPhoneController = TextEditingController();
  final _userMailController = TextEditingController();
  final _userBioController = TextEditingController();
  final _userPriceController = TextEditingController();

  void _saveData() {
    List<String> data = [
      _userPhoneController.text,
      _userMailController.text,
      _userBioController.text,
      _userPriceController.text
    ];
    Navigator.of(context).pop(data);
  }

  @override
  void initState() {
    super.initState();

    // Set the initial data from widget properties to the controllers
    _userPhoneController.text = widget.phoneNumber;
    _userMailController.text = widget.eMail;
    _userBioController.text = widget.bio;
    _userPriceController.text = widget.pricePerHour.toString() ;

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color(0xFF2F4771),
        content: Container(
          height: MediaQuery.of(context).size.height / 2.2,
          width: 350,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text("Edit Personal Info",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFF3D69B)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _userPhoneController, hintText: "Enter Your new Number", labelText: "Phone Number"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _userMailController, hintText: "Enter Your new E-Mail", labelText: "E-Mail"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _userPriceController, hintText: "Enter Your new price", labelText: "Price / Hour"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _userBioController, hintText: "Enter Your new bio", labelText: "Your Bio"),
              ),
              Padding(
                padding: const EdgeInsets.only(top : 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: _saveData ,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
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
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
