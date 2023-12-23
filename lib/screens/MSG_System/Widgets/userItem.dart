import 'package:buildnex/screens/MSG_System/chatScreen.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


class UserItemProfile extends StatefulWidget {
  final UserModel user ;
  const UserItemProfile({super.key , required this.user});

  @override
  State<UserItemProfile> createState() => _UserItemProfileState();
}

class _UserItemProfileState extends State<UserItemProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(ChatScreen(user: widget.user,));
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.user.image),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CircleAvatar(
                backgroundColor: widget.user.isOnline
                  ? Colors.green[800]
                  : Colors.grey,
                radius: 5,
              ),
            )
          ]
        ),
        title: Text(
          widget.user.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          'Last Active : ${timeago.format(widget.user.lastActive)}',
          maxLines: 2,
          style: const TextStyle(
            color: Color(0xFF2F4771),
            fontSize: 15,
            overflow: TextOverflow.ellipsis
          ),
        ),
      ),
    );
  }
}
