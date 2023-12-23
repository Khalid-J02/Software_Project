import 'package:buildnex/screens/MSG_System/Widgets/messageBubble.dart';
import 'package:buildnex/screens/MSG_System/models/message.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {

  final String receiverID ;

  ChatMessages({super.key , required this.receiverID});

  final List<Message> messages = List.generate(
    20,
        (index) => Message(
      senderID: index % 2 == 0 ? 'user1' : 'user2', // Alternate between 2 users
      receiverID: index % 2 == 0 ? 'user2' : 'user1',
      content: index % 3 == 0
          ? 'https://picsum.photos/200/100' // Image message content
          : 'Message $index content',
      sentTime: DateTime.now().subtract(Duration(minutes: index * 5)),
      messageType: index % 3 == 0 ? MessageType.image : MessageType.text, // Assign message types
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context , index){
        final isMe = receiverID != messages[index].senderID ;

        final isTextMessage = messages[index].messageType == MessageType.text;

        return isTextMessage
          ? MessageBubble(message: messages[index], isMe: isMe, isImage: false,)
          : MessageBubble(message: messages[index], isMe: isMe, isImage: true,);
      },
    );
  }
}
