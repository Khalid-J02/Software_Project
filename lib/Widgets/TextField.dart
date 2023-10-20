import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller ;
  final String hintText ;
  final String labelText ;

  const Textfield(
      {
        super.key,
        required this.controller,
        required this.hintText,
        required this.labelText
      }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Color(0xFFF3D69B)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFFF3D69B)),
        filled: true,
        fillColor: Color(0xFF6781A6),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFF3D69B),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFF3D69B),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFF3D69B),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
