import 'package:flutter/material.dart';

class CustomNewMessageNotification extends StatefulWidget {
  final String userPictureUrl;
  final String userName;
  final String notificationContent;
  final bool IsRead;


  const CustomNewMessageNotification({
    Key? key,
    required this.userPictureUrl,
    required this.userName,
    required this.notificationContent,
    required this.IsRead,
  }) : super(key: key);

  @override
  State<CustomNewMessageNotification> createState() => _CustomNewMessageNotificationState();
}


class _CustomNewMessageNotificationState extends State<CustomNewMessageNotification> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.IsRead ? Colors.white : Color(0xFFE7F1FF); // Light blue for unread, white for read

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.grey.shade300),
          bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
        ),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 27,
              backgroundImage: NetworkImage(widget.userPictureUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.notificationContent,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}