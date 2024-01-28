import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';

import '../classes/language_constants.dart';

class ServiceProviderProfileDataDialog extends StatefulWidget {
  String phoneNumber;
  String eMail;
  String bio;
  int pricePerHour;

  ServiceProviderProfileDataDialog(
      {super.key,
      required this.phoneNumber,
      required this.eMail,
      required this.bio,
      required this.pricePerHour});

  @override
  State<ServiceProviderProfileDataDialog> createState() =>
      _ServiceProviderProfileDataDialogState();
}

class _ServiceProviderProfileDataDialogState
    extends State<ServiceProviderProfileDataDialog> {
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
    _userPriceController.text = widget.pricePerHour.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: AlertDialog(
        backgroundColor: Color(0xFF2F4771),
        content: Container(
          height: MediaQuery.of(context).size.height / 2.05,
          width: 350,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Text(
                  translation(context)!
                      .serviceProviderProfileDialogEditPersonalInfoTitle,
                  style: TextStyle(fontSize: 22, color: Color(0xFFF3D69B)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10.0),
                child: Textfield(
                    controller: _userPhoneController,
                    hintText: translation(context)!
                        .serviceProviderProfileDialogPhoneNumberHint,
                    labelText: translation(context)!
                        .serviceProviderProfileDialogPhoneNumberLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10.0),
                child: Textfield(
                    controller: _userMailController,
                    hintText: translation(context)!
                        .serviceProviderProfileDialogEmailHint,
                    labelText: translation(context)!
                        .serviceProviderProfileDialogEmailLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10.0),
                child: Textfield(
                    controller: _userPriceController,
                    hintText: translation(context)!
                        .serviceProviderProfileDialogPricePerHourHint,
                    labelText: translation(context)!
                        .serviceProviderProfileDialogPricePerHourLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 6.0, bottom: 10.0),
                child: Textfield(
                    controller: _userBioController,
                    hintText: translation(context)!
                        .serviceProviderProfileDialogBioHint,
                    labelText: translation(context)!
                        .serviceProviderProfileDialogBioLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
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
                        onPressed: _saveData,
                        child: Text(
                          translation(context)!
                              .serviceProviderProfileDialogSaveButton,
                          style: const TextStyle(
                            fontSize: 19,
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
                        child: Text(
                          translation(context)!
                              .serviceProviderProfileDialogCancelButton,
                          style: const TextStyle(
                            fontSize: 19,
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
        ),
      ),
    );
  }
}
