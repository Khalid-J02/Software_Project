import 'package:buildnex/screens/MSG_System/listChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MsgSystem ());
}

class MsgSystem extends StatelessWidget {
  const MsgSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListChatScreen(),
    );
  }
}
