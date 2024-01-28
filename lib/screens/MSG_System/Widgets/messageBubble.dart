import 'package:buildnex/screens/MSG_System/models/message.dart';
import 'package:flutter/material.dart';
import '../../../classes/language_constants.dart';

class MessageBubble extends StatelessWidget {
  final Message message ;
  final bool isMe ;
  final bool isImage ;

  const MessageBubble({super.key , required this.message , required this.isMe , required this.isImage});

  String translateTimeAgo(String sentTime, BuildContext context) {
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
      'ago': '',
    };

    if (Localizations.localeOf(context).languageCode == 'ar') {
      translations.forEach((english, arabic) {
        sentTime = sentTime.replaceAll(english, arabic);
      });
    }

    return sentTime;
  }

  @override
  Widget build(BuildContext context) {
    String sentTime = translateTimeAgo(message.sentTime, context);

    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: Align(
      alignment: isMe ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? Color(0x983A3939): Color(0xFF2F4771),
          borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)
              )
            : const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)
          ),
        ),
        margin: const EdgeInsets.only(top: 5, right: 10 , left: 10, bottom: 5),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isMe
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
          children: [
            isImage ?
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(message.content),
                  fit: BoxFit.cover,
                )
              ),
            )
            :
            Text(
              message.content,
              style: const TextStyle(
                color: Colors.white ,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              sentTime,
              style:  const TextStyle(
                  color: Colors.white ,
                fontSize: 11
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
