import 'package:flutter/material.dart';

import '../../../Widgets/ratingBar_ServiceProvider.dart';

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
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: AssetImage(userPicture),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Me",
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 3.0),
            Row(
              children: [
                RatingBarSB(rating: rating, size: 15,),
                const SizedBox(width: 8.0),
                Text(
                  rating.toString(),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '($numReviews reviews)',
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
