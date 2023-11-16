import 'package:buildnex/Widgets/sp_CatalogItemColorPicker.dart';
import 'package:flutter/material.dart';

class SPItemColor extends StatefulWidget {
  Color itemColor ;

  SPItemColor(
      {
        super.key,
        required this.itemColor,

      }
      );

  @override
  State<SPItemColor> createState() => _SPItemColorState();
}

class _SPItemColorState extends State<SPItemColor> {

  Future <List<Color>?> editCatalogItemColor()=> showDialog <List<Color>>(
      context: context,
      builder: (BuildContext context){
        return ItemColorPicker(currentItemColor: widget.itemColor,);
        // return ServiceProviderCatalogItemDataDialog(itemName: widget.itemName, itemDescription: itemDescription, itemColors: itemColors,);
      }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0 , bottom: 8),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.itemColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: (){},
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xFFF9FAFB),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              List<Color>? UpdatedData = await editCatalogItemColor();
              setState(() {
                if(UpdatedData != null){
                  widget.itemColor = UpdatedData![0];
                }
              });
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xFFF9FAFB),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: const Icon(
                Icons.edit,
                size: 16,
                color: Color(0xFF122247),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

