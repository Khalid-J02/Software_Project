import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';

import 'itemColor_spCatalog.dart';

class ServiceProviderCatalogItemDialog extends StatefulWidget {

  String itemName ;
  String itemDescription;
  List<Color> itemColors ;

  ServiceProviderCatalogItemDialog(
      {
        super.key,
        required this.itemName,
        required this.itemDescription,
        required this.itemColors,
      });

  @override
  State<ServiceProviderCatalogItemDialog> createState() => _ServiceProviderCatalogItemDataDialogState();
}

class _ServiceProviderCatalogItemDataDialogState extends State<ServiceProviderCatalogItemDialog> {

  final _itemNameController = TextEditingController();
  final _itemDescriptionController = TextEditingController();

  void _saveData() {
    List<String> data = [
      _itemNameController.text,
      _itemDescriptionController.text,
    ];
    Navigator.of(context).pop(data);
  }
  void onItemColorUpdated(Color newColor, int index) {
    setState(() {
      // Update the itemColors list with the new color at the correct index
      widget.itemColors[index] = newColor;
    });
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
          height: MediaQuery.of(context).size.height / 2.2,
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
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: Textfield(controller: _itemDescriptionController, hintText: "Item New Description", labelText: "Item Description"),
              ),
              Container(
                height: 150,
                padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 8.0 , bottom: 12.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.itemColors.length,
                  itemBuilder: (context, index) {
                    return SPItemColor(itemColor: widget.itemColors[index], onColorUpdated: (newColor) => onItemColorUpdated(newColor, index),);
                  },
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