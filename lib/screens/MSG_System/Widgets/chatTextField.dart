import 'dart:convert';
import 'dart:io';

import 'package:buildnex/screens/MSG_System/Widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class ChatTextField extends StatefulWidget {
  final String receiverId; // Add this line
  final Function? onSendMessage; // For callback approach

  const ChatTextField({super.key, required this.receiverId , required this.onSendMessage}); // Modify this line

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();

  Future<void> sendMessage() async {
    if (controller.text.isNotEmpty) {
      try {
        // var response = await MessagingAPI.sendMessage(widget.receiverId, controller.text);
        widget.onSendMessage!(controller);
        controller.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
     // CustomAlertDialog.showErrorDialog(context, 'Please enter a message before sending.');
    }
  }

  Image? image;
  late final pickedImage ;
  final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  Future<void> pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      setState(() {
        image = Image.file(imageFile);
      });
    }
    if (image != null) {
      final url = Uri.parse(cloudinaryUrl) ;
      final req = http.MultipartRequest('POST' , url)
        ..fields['upload_preset'] = 'buildnex'
        ..files.add(await http.MultipartFile.fromPath('file', pickedImage.path)) ;

      final response = await req.send();
      if(response.statusCode == 200){
        final responseData = await response.stream.toBytes() ;
        final responseString = String.fromCharCodes(responseData) ;
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'] ;
          controller.text = url ;
        });
      }
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
            onPressed: sendMessage,
          ),
        ),
        const SizedBox(width: 5,),
        CircleAvatar(
          backgroundColor: Color(0xFF2F4771),
          radius: 20,
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white,),
            onPressed: () async {
              await pickImage() ;
              sendMessage();
            },
          ),
        ),
      ],
    );
  }
}
