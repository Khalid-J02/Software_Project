import 'package:buildnex/APIRequests/messageSystem.dart';
import 'package:buildnex/screens/MSG_System/Widgets/chatMessages.dart';
import 'package:buildnex/screens/MSG_System/Widgets/chatTextField.dart';
import 'package:buildnex/screens/MSG_System/models/message.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user ;

  const ChatScreen({super.key , required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<Message> messages = [];

  Future <void> fetchConversation() async {
    try {
      var response = await MessagingAPI.getConversation(widget.user.uid);
      setState(() {
        messages = response.map((m) => Message.fromJson(m)).toList();
      });
    } catch (e) {
      print('Error fetching conversation: $e');
    }
  }

  Future<void> sendMessage(TextEditingController controller) async {
    if (controller.text.isNotEmpty) {
      try {
        var response = await MessagingAPI.sendMessage(widget.user.uid, controller.text);
        fetchConversation() ;
        controller.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
      // CustomAlertDialog.showErrorDialog(context, 'Please enter a message before sending.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: ChatMessages(receiverID: widget.user.uid, messages: messages,)),
              ChatTextField(receiverId: widget.user.uid, onSendMessage: sendMessage,),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      foregroundColor: Color(0xFF122247),
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image),
            radius: 20,
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                widget.user.isOnline
                  ? 'Online'
                  : 'Offline',
                style: TextStyle(
                  color: widget.user.isOnline
                    ? Colors.green[800]
                    : Colors.grey,
                  fontSize: 14
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
