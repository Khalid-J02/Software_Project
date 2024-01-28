import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import '../APIRequests/serviceProviderCatalogAPI.dart';
import '../classes/language_constants.dart';
import 'itemColor_spCatalog.dart';

class ServiceProviderCatalogItemDataDialog extends StatefulWidget {
  String catalogID;
  String itemName;
  String itemPrice;
  String itemDescription;
  List<Color> itemColors;

  ServiceProviderCatalogItemDataDialog({
    super.key,
    required this.catalogID,
    required this.itemName,
    required this.itemPrice,
    required this.itemDescription,
    required this.itemColors,
  });

  @override
  State<ServiceProviderCatalogItemDataDialog> createState() =>
      _ServiceProviderCatalogItemDataDialogState();
}

class _ServiceProviderCatalogItemDataDialogState
    extends State<ServiceProviderCatalogItemDataDialog> {
  final _itemNameController = TextEditingController();
  final _itemPriceController = TextEditingController();
  final _itemDescriptionController = TextEditingController();

  Future<void> _saveData() async {
    List<dynamic> data = [
      _itemNameController.text,
      _itemPriceController.text,
      _itemDescriptionController.text,
      widget.itemColors,
    ];
    Navigator.of(context).pop(data);

    String updatedItemName = _itemNameController.text;
    double updatedItemPrice = double.tryParse(_itemPriceController.text) ?? 0.0;
    String updatedItemDescription = _itemDescriptionController.text;

    String message = await CatalogAPI.editItemDetails(
      widget.catalogID,
      updatedItemName,
      updatedItemPrice,
      updatedItemDescription,
      widget.itemColors.map((color) {
        return 'Color(0x${color.value.toRadixString(16)})';
      }).toList(),
    );
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
    _itemPriceController.text = widget.itemPrice;
    _itemDescriptionController.text = widget.itemDescription;
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
          height: MediaQuery.of(context).size.width > 930
              ? MediaQuery.of(context).size.height / 1.9
              : MediaQuery.of(context).size.height / 1.80,
          width: 350,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 7.0),
                child: Text(
                  translation(context)!.sp_CatalogItemTitle,
                  style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 930 ? 26 : 22,
                      color: Color(0xFFF3D69B)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 7.0, bottom: 10.0),
                child: Textfield(
                    controller: _itemNameController,
                    hintText: translation(context)!.sp_CatalogItemNewNameHint,
                    labelText:
                        translation(context)!.sp_CatalogItemNewNameLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 7.0, bottom: 10.0),
                child: Textfield(
                    controller: _itemPriceController,
                    hintText: translation(context)!.sp_CatalogItemNewPriceHint,
                    labelText:
                        translation(context)!.sp_CatalogItemNewPriceLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 7.0, bottom: 10.0),
                child: Textfield(
                    controller: _itemDescriptionController,
                    hintText: translation(context)!.sp_CatalogItemNewDescHint,
                    labelText:
                        translation(context)!.sp_CatalogItemNewDescLabel),
              ),
              Container(
                height: MediaQuery.of(context).size.width > 930 ? 160 : 125,
                padding: const EdgeInsets.only(
                    left: 5.0, right: 8.0, top: 8.0, bottom: 12.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.itemColors.length,
                  itemBuilder: (context, index) {
                    return SPItemColor(
                      itemColor: widget.itemColors[index],
                      onColorUpdated: (newColor) =>
                          onItemColorUpdated(newColor, index),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width:
                          MediaQuery.of(context).size.width > 930 ? 120 : 100,
                      padding: MediaQuery.of(context).size.width > 930
                          ? EdgeInsets.symmetric(vertical: 8)
                          : EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _saveData();
                        },
                        child: Text(
                          translation(context)!
                              .serviceProviderProfileDialogSaveButton,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 930
                                ? 23
                                : 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width:
                          MediaQuery.of(context).size.width > 930 ? 120 : 100,
                      padding: MediaQuery.of(context).size.width > 930
                          ? EdgeInsets.symmetric(vertical: 8)
                          : EdgeInsets.zero,
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
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 930
                                ? 23
                                : 20,
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
