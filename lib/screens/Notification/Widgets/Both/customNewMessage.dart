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

String translateNotifications(String notification, BuildContext context) {
  // Your translations map
  const translations = {
    'You have received a new task request from Homeowner': 'لقد تلقيت طلب مهمة جديد من صاحب المنزل',
    'Homeowner': 'صاحب المنزل',
    'has updated their review.': 'قام بتحديث تقييمه.',
    'has left a new review.': 'قام بترك تقييم جديد.',
    'Your request for Task': 'طلبك للمهمة',
    'has been declined by the service provider': 'تم رفضه من قبل مقدم الخدمة',
    '. Reason: ': '. السبب: ',
    ' has been accepted by the service provider ': ' تم قبوله من قبل مقدم الخدمة ',
    'You have received a new message from ': 'لقد تلقيت رسالة جديدة من ',
  };

  if (Localizations.localeOf(context).languageCode == 'ar') {
    translations.forEach((english, arabic) {
      notification = notification.replaceAll(english, arabic);
    });
  }

  return notification;
}

class _CustomNewMessageNotificationState extends State<CustomNewMessageNotification> {
  @override
  Widget build(BuildContext context) {
    String notificationContentTranslate = translateNotifications(widget.notificationContent, context);
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
                    notificationContentTranslate,
                    style: const TextStyle(
                      fontSize: 16,
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