import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewItemColorPicker extends StatefulWidget {
  const NewItemColorPicker({super.key});

  @override
  State<NewItemColorPicker> createState() => _NewItemColorPickerState();
}

class _NewItemColorPickerState extends State<NewItemColorPicker> {

  late Color itemColor = Colors.white ;
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
          pickerColor: itemColor,
          onColorChanged: (Color value){
            setState(() => itemColor = value);
            print(itemColor) ;
            Navigator.of(context).pop([itemColor]) ;
          },
        ),
      ),
    );
  }
}
