import 'package:buildnex/classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileData extends StatefulWidget {
  String userName ;
  String userRole ;
  String userEmail ;
  String userBio  ;
  String userPhone ;

  ProfileData(
      {
        super.key,
        required this.userName,
        required this.userRole,
        required this.userEmail,
        required this.userBio,
        required this.userPhone
      }
      );

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {

  @override
  Widget build(BuildContext context) {
    if(translation(context)!.localeName == 'ar'){
      if(widget.userRole == 'HomeOwner'){
        setState(() {
          widget.userRole = 'مالك منزل' ;
        });
      }
    }
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
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
          Container(
            padding: const EdgeInsets.only(top: 35, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(translation(context)!.homeOwnerProfilePhone,
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
                Text(
                translation(context)!.homeOwnerProfileEMail,
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
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 12, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(translation(context)!.homeOwnerProfileBio,
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

      ),
    );
  }
}
