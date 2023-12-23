import 'package:buildnex/screens/MSG_System/Widgets/customTextFormField.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            hintText: 'Add Message...',
            labelText: 'Message',
            obscureData: null,
            onChanged: (String value) {  },
            onPressedSuffixIcon: () {  },
            prefixIcon: null,
            suffixIcon: null, ),
        ),
        const SizedBox(width: 5,),
        CircleAvatar(
          backgroundColor: Color(0xFF2F4771),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white,),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 5,),
        CircleAvatar(
          backgroundColor: Color(0xFF2F4771),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white,),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
