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
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFFcce2e6),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black45,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
