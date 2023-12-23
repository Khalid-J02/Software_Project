import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller ;
  final IconData? prefixIcon ;
  final IconData? suffixIcon ;
  final String? labelText ;
  final String? hintText ;
  final bool? obscureData;
  final VoidCallback? onPressedSuffixIcon ;
  final ValueChanged<String>? onChanged ;

  const CustomTextFormField(
      {
        super.key,
        required this.controller,
        required this.hintText,
        required this.labelText,
        required this.obscureData,
        required this.onChanged,
        required this.onPressedSuffixIcon,
        required this.prefixIcon,
        required this.suffixIcon,
      }
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureData ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
          ? IconButton(
              onPressed: onPressedSuffixIcon,
              icon: Icon(suffixIcon),
            )
          : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF122247))
        )
      ),
    );
  }
}
