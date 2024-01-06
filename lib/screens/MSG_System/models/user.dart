import 'package:flutter/material.dart';

class UserModel {
  late final String uid ;
  late final String name ;
  late final String email ;
  late final String image ;
  late final String lastActive ;
  late final bool isOnline ;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.isOnline,
    required this.lastActive
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['UserID'].toString(),
      name: json['Username'],
      email: json['Email'],
      image: json['UserPicture'],
      isOnline: json['OnlineStatus'] == 'true',
      lastActive: json['LastActive'],
    );
  }
}