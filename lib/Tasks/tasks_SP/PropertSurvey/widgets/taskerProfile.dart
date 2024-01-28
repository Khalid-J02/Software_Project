import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:flutter/material.dart';

import '../../../../classes/language_constants.dart';

class TaskerProfileData extends StatelessWidget {
  final String userPicture;
  final double rating;
  final int numReviews;

  const TaskerProfileData({
    Key? key,
    required this.userPicture,
    required this.rating,
    required this.numReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(userPicture),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation(context)!.taskProviderInformationName,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF2F4771),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3.0),
              Row(
                children: [
                  RatingBarSB(
                    rating: rating,
                    size: 15,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    rating.toString(),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '($numReviews  ${translation(context)!.taskProviderInformationReviews})',
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
