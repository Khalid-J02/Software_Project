import 'package:buildnex/screens/MSG_System/chatScreen.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../classes/language_constants.dart';
class UserItemProfile extends StatefulWidget {
  final UserModel user;
  const UserItemProfile({super.key, required this.user});

  @override
  State<UserItemProfile> createState() => _UserItemProfileState();
}

class _UserItemProfileState extends State<UserItemProfile> {

  String translateTimeAgo(String lastActive, BuildContext context) {
    // Your translations map
    const translations = {
      'a moment ago': 'للتو',
      'seconds': 'ثواني',
      'minutes': 'دقائق',
      'hours': 'ساعات',
      'days': 'أيام',
      'hour': 'ساعة',
      'minute': 'دقيقة',
      'day': 'يوم',
      'and': 'و',
      'second': 'ثانية',
      'ago': 'مضت',
    };

    if (Localizations.localeOf(context).languageCode == 'ar') {
      translations.forEach((english, arabic) {
        lastActive = lastActive.replaceAll(english, arabic);
      });
    }

    // Return the translated (or original) lastActive string
    return lastActive;
  }

  @override
  Widget build(BuildContext context) {
    String lastActiveTranslated = translateTimeAgo(widget.user.lastActive, context);
    bool isUnread = widget.user.conversationStatus == 'unread';
    bool isRead = widget.user.conversationStatus == 'read';
    bool isDefault = widget.user.conversationStatus == 'Default';

    TextStyle titleStyle;
    if (isUnread) {
      titleStyle = const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      );
    } else if (isRead) {
      titleStyle = const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.normal,
      );
    } else { // isDefault
      titleStyle = const TextStyle(
        color: Colors.grey,
        fontSize: 17,
        fontWeight: FontWeight.normal,
      );
    }

    return GestureDetector(
      onTap: (){
        Get.to(() => ChatScreen(user: widget.user));
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
                  backgroundColor: widget.user.isOnline ? Colors.green[800] : Colors.grey,
                  radius: 5,
                ),
              ),
            ]
        ),
        title: Text(widget.user.name, style: titleStyle),
        subtitle: Text(
          '${translation(context)!.userItemLastActive} $lastActiveTranslated',
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
