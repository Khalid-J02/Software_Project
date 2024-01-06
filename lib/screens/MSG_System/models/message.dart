import 'package:flutter/material.dart';

class Message{
  final String senderID;
  final String receiverID;
  final String content;
  final String sentTime;
  final MessageType messageType;

  const Message({
    required this.senderID,
    required this.receiverID,
    required this.content,
    required this.sentTime,
    required this.messageType
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    MessageType type = _determineMessageType(json['content']);

    return Message(
      senderID: json['senderId'].toString(),
      receiverID: json['receiverId'].toString(),
      content: json['content'],
      sentTime: json['howLong'],
      messageType:type ,
    );
  }

  static MessageType _determineMessageType(String content) {
    if (Uri.tryParse(content)?.hasAbsolutePath ?? false) {
      return MessageType.image;
    } else {
      return MessageType.text;
    }
  }
}

enum MessageType {
  text,
  image,
}