import 'package:buildnex/Widgets/ratingBar_ServiceProvider.dart';
import 'package:flutter/material.dart';

class ServiceProviderData extends StatefulWidget {
  String userName;
  String userRole;

  String userEmail;
  String userBio;
  String userPhone;
  double userRating;
  int userPrice ;

  ServiceProviderData(
      {
        super.key,
        required this.userName,
        required this.userRole,
        required this.userEmail,
        required this.userBio,
        required this.userPhone,
        required this.userRating,
        required this.userPrice
      }
  );

  @override
  State<ServiceProviderData> createState() => _ServiceProviderDataState();
}

class _ServiceProviderDataState extends State<ServiceProviderData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Text(widget.userName,
            style: const TextStyle(
                color: Color(0xFFF9FAFB),
                fontSize: 30,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(widget.userRole,
            style: const TextStyle(
                color: Color(0xFFF9FAFB),
                fontSize: 22,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
              children: [
                RatingBarSB(rating: 3.7, size: 20)
              ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Phone Number',
                style: TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
              Text(widget.userPhone,
                style: const TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('E-Mail',
                style: TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
              Text(widget.userEmail,
                style: const TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Price / Hour',
                style: TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
              Text("${widget.userPrice.toString()} JOD",
                style: const TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Bio: ',
                style: TextStyle(
                    color: Color(0xFFF9FAFB),
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.userBio,
                  style: const TextStyle(
                      color: Color(0xFFF9FAFB),
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        ),
      ],

    );
  }
}
