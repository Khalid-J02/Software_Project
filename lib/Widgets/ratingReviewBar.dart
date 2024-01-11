import 'package:flutter/material.dart';

class RatingReview extends StatelessWidget {

  String text ;
  double value ;

  RatingReview({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text ,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width > 930
                  ? 20
                  : 16,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: MediaQuery.of(context).size.width * 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value,
                minHeight: MediaQuery.of(context).size.width > 930
                    ? 14
                    : 10,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF122247)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
