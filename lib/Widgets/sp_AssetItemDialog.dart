import 'package:buildnex/APIRequests/serviceProviderWorkExpAPI.dart';
import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';

import 'itemColor_spCatalog.dart';

class ServiceProviderAssetItemDataDialog extends StatefulWidget {

  String itemName ;
  String itemDescription;
  String itemID ;

  ServiceProviderAssetItemDataDialog(
      {
        super.key,
        required this.itemName,
        required this.itemDescription,
        required this.itemID,
      });

  @override
  State<ServiceProviderAssetItemDataDialog> createState() => _ServiceProviderAssetItemDataDialogState();
}

class _ServiceProviderAssetItemDataDialogState extends State<ServiceProviderAssetItemDataDialog> {

  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();

  Future<void> _saveData() async {
    String response = await WorkExperienceAPI.editWorkExpDetails(widget.itemID, _itemNameController.text, _itemDescriptionController.text) ;
    List<String> data = [
      _itemNameController.text,
      _itemDescriptionController.text,
    ];
    Navigator.of(context).pop(data);
  }

  @override
  void initState() {
    super.initState();

    // Set the initial data from widget properties to the controllers
    _itemNameController.text = widget.itemName;
    _itemDescriptionController.text = widget.itemDescription;

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color(0xFF2F4771),
        content: Container(
          height: MediaQuery.of(context).size.height / 3.3,
          width: 350,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text("Edit Item Info",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFF3D69B)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _itemNameController, hintText: "Enter Item New Name", labelText: "Item Name"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 12.0 , bottom: 12.0),
                child: Textfield(controller: _itemDescriptionController, hintText: "Item New Description", labelText: "Item Description"),
              ),
              Padding(
                padding: const EdgeInsets.only(top : 20.0),
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
