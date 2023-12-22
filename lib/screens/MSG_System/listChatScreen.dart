import 'package:buildnex/screens/MSG_System/Widgets/userItem.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListChatScreen> {

  List userData =[
    UserModel(
      uid: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
      image: 'https://picsum.photos/200/100',
      isOnline: true,
      lastActive: DateTime.now(),
    ),
    UserModel(
      uid: '2',
      name: 'Jane Smith',
      email: 'janesmith@example.com',
      image: 'https://picsum.photos/200/200',
      isOnline: false,
      lastActive: DateTime.now().subtract(Duration(hours: 2)),
    ),
    UserModel(
      uid: '3',
      name: 'Emily Jones',
      email: 'emilyjones@example.com',
      image: 'https://picsum.photos/200/300',
      isOnline: true,
      lastActive: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    UserModel(
      uid: '4',
      name: 'David Miller',
      email: 'davidmiller@example.com',
      image: 'https://picsum.photos/200/400',
      isOnline: false,
      lastActive: DateTime.now().subtract(Duration(days: 1)),
    ),
    UserModel(
      uid: '5',
      name: 'Lisa Brown',
      email: 'lisabrown@example.com',
      image: 'https://picsum.photos/200/500',
      isOnline: true,
      lastActive: DateTime.now().subtract(Duration(hours: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFFF3D69B),
            fontSize: 22
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247),//Colors.white,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: userData.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return UserItemProfile(user: userData[index],);
          },
        ),
      ),
    );
  }
}
