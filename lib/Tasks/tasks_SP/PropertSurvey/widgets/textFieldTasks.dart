import 'package:flutter/material.dart';

class TextfieldTasks extends StatelessWidget {
  final TextEditingController controller ;
  final String hintText ;
  final String labelText ;

  const TextfieldTasks(
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
      style: TextStyle(color: Color(0xFF2F4771)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF2F4771)),
        filled: true,
        fillColor: Color(0xFFF9FAFB),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF2F4771),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFF2F4771),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFF2F4771),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
