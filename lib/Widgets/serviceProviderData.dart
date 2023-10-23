import 'package:flutter/material.dart';

class ServiceProviderData extends StatefulWidget {
  String userName;
  String userRole;

  String userEmail;
  String userBio;
  String userPhone;

  ServiceProviderData(
      {super.key,
      required this.userName,
      required this.userRole,
      required this.userEmail,
      required this.userBio,
      required this.userPhone
      }
  );

  @override
  State<ServiceProviderData> createState() => _ServiceProviderDataState();
}

class _ServiceProviderDataState extends State<ServiceProviderData> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
