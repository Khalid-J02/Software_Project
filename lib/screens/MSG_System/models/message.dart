import 'package:flutter/material.dart';

class Message{
  final String senderID;
  final String receiverID;
  final String content;
  final DateTime sentTime;
  final MessageType messageType;

  const Message({
    required this.senderID,
    required this.receiverID,
    required this.content,
    required this.sentTime,
    required this.messageType
  });
}

enum MessageType{
  text,
  image ;
}