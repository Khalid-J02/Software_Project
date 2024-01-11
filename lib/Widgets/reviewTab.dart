import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class SPReviews extends StatefulWidget {
  String imageURL ;
  String name;
  double rating ;
  String date;
  String reviewText ;

  SPReviews(
      {
        super.key,
        required this.imageURL,
        required this.name,
        required this.rating,
        required this.date,
        required this.reviewText,
      }
  );

  @override
  State<SPReviews> createState() => _SPReviewsState();
}

class _SPReviewsState extends State<SPReviews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 930
          ? const EdgeInsets.symmetric(horizontal: 25.0 , vertical: 12)
          : const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(widget.imageURL),
                radius: MediaQuery.of(context).size.width > 930
                  ? 35
                  : 20,
              ),
              SizedBox(width: MediaQuery.of(context).size.width > 930
                  ? 18
                  : 12,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(widget.name , style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 930
                    ? 22
                    : 17 ,
                  fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width > 930
              ? 14
              : 10,),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.rating,
                itemSize: MediaQuery.of(context).size.width > 930
                    ? 22
                    : 18,
                unratedColor: Colors.grey,
                itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFF122247),),
              ),
              SizedBox(width: MediaQuery.of(context).size.width > 930
                  ? 14
                  : 10,),
              Text(widget.date , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: MediaQuery.of(context).size.width > 930
                  ? 20
                  : 15),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width > 930
              ? 14
              : 10,),

          ReadMoreText(
            widget.reviewText,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimExpandedText: '  show less',
            trimCollapsedText: '  show more',
            moreStyle: TextStyle(fontSize: MediaQuery.of(context).size.width > 930
                ? 25
                : 14 , fontWeight: FontWeight.bold , color: Color(0xFF122247)),
            lessStyle: TextStyle(fontSize:MediaQuery.of(context).size.width > 930
                ? 25
                : 14 , fontWeight: FontWeight.bold , color: Color(0xFF122247)),
          ),

        ],
      ),
    );
  }
}
