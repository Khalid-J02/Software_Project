import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';

class CatalogNewItem extends StatefulWidget {
  const CatalogNewItem({super.key});

  @override
  State<CatalogNewItem> createState() => _CatalogNewItemState();
}

class _CatalogNewItemState extends State<CatalogNewItem> {


  final _ItemName = TextEditingController();
  final _itemDescription = TextEditingController();
  final _itemPrice = TextEditingController();

  List<Color> itemColors = [];
  void _addColor(Color color) {
    setState(() {
      itemColors.add(color);
    });
  }

  void _removeColor(int index) {
    setState(() {
      itemColors.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: Container(
        height: 400,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text("Add New Catalog Item",
                style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFFF3D69B)
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12 , bottom: 12 ),
              child: Textfield(controller: _ItemName, hintText: "Enter Item Name", labelText: "Item Name"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12 , bottom: 12 ),
              child: Textfield(controller: _itemDescription, hintText: "Enter Item Description", labelText: "Item Description"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12 , bottom: 12 ),
              child: Textfield(controller: _itemPrice, hintText: "Enter Item Price", labelText: "Item Price"),
            ),
          ],
        ),
      ),

    );
  }
}
