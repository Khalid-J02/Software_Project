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
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the axis
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(widget.imageURL)),
              SizedBox(width: 12),
              Expanded( // Make the text take the remaining space
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis, // Add ellipsis for overflowed text
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.rating,
                itemSize: 18,
                unratedColor: Colors.grey,
                itemBuilder: (_, __) => Icon(Icons.star, color: Color(0xFF122247)),
              ),
              SizedBox(width: 10),
              Text(widget.date, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            ],
          ),
          SizedBox(height: 10),
          ReadMoreText(
            widget.reviewText,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimExpandedText: ' show less',
            trimCollapsedText: ' show more',
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF122247)),
            lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF122247)),
          ),
        ],
      ),
    );
  }
}