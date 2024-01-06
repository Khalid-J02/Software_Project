import 'package:buildnex/screens/MSG_System/Widgets/customTextFormField.dart';
import 'package:flutter/material.dart';

import '../../../APIRequests/messageSystem.dart';
import '../../../Widgets/customAlertDialog.dart';

class ChatTextField extends StatefulWidget {
  final String receiverId; // Add this line

  const ChatTextField({super.key, required this.receiverId}); // Modify this line

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      try {
        var response = await MessagingAPI.sendMessage(widget.receiverId, controller.text);
        controller.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
     // CustomAlertDialog.showErrorDialog(context, 'Please enter a message before sending.');
    }
  }
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
            onPressed: _sendMessage,
          ),
        ),
        const SizedBox(width: 5,),
        CircleAvatar(
          backgroundColor: Color(0xFF2F4771),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white,),
            onPressed: _sendMessage,
          ),
        ),
      ],
    );
  }
}
