import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ItemColorPicker extends StatefulWidget {
  Color currentItemColor ;

  ItemColorPicker(
      {
        super.key,
        required this.currentItemColor,
      }
  );


  @override
  State<ItemColorPicker> createState() => _ItemColorPickerState();
}

class _ItemColorPickerState extends State<ItemColorPicker> {

  late Color itemCurrentColor ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemCurrentColor = widget.currentItemColor ;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF9FAFB),
      title: const Text(
        "Pick a new color !",
        style: TextStyle(
            fontSize: 20,
            color: Color(0xFF122247)
        ),
      ),
      content: SingleChildScrollView(
        child: MaterialPicker(
          pickerColor: itemCurrentColor,
          onColorChanged: (Color value){
            setState(() => itemCurrentColor = value);
            Navigator.of(context).pop([itemCurrentColor]) ;
          },
        ),
      ),
    );
  }
}

