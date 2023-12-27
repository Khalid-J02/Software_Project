import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:flutter/material.dart';


class SPProfileData extends StatelessWidget {
  final String userPicture;
  final String userName ;
  final double rating;
  final int numReviews;

  const SPProfileData({
    Key? key,
    required this.userPicture,
    required this.userName,
    required this.rating,
    required this.numReviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      height: MediaQuery.of(context).size.height/7 + 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/17 ,
              decoration: BoxDecoration(
                color: Color(0xFF6781A6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                border: Border.all(
                  color: Color(0xFF2F4771),
                  width: 1.0,
                ),
              ),
              child: const Center(
                child: Text(
                  "Task Provider",
                  style: TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
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
                        userName,
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
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
