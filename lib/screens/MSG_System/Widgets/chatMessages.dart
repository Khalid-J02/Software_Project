import 'package:buildnex/screens/MSG_System/Widgets/messageBubble.dart';
import 'package:buildnex/screens/MSG_System/models/message.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  final String receiverID;
  final List<Message> messages;
  final ScrollController scrollController;

  ChatMessages({
    super.key,
    required this.receiverID,
    required this.messages,
    required this.scrollController,
  });

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  // List<Message> messages = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchConversation();
  // }
  //
  // Future <void> fetchConversation() async {
  //   try {
  //     var response = await MessagingAPI.getConversation(widget.receiverID);
  //     setState(() {
  //       messages = response.map((m) => Message.fromJson(m)).toList();
  //     });
  //   } catch (e) {
  //     print('Error fetching conversation: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final isMe = widget.receiverID == widget.messages[index].senderID;
        final isTextMessage = widget.messages[index].messageType ==
            MessageType.text;

        return isTextMessage
            ? MessageBubble(
            message: widget.messages[index], isMe: isMe, isImage: false)
            : MessageBubble(
            message: widget.messages[index], isMe: isMe, isImage: true);
      },
    );
  }
}