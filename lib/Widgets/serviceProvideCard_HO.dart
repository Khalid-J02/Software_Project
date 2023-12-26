import 'package:buildnex/screens/sPProfilePage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ho_serviceProviderCard.dart';

class SPCard extends StatefulWidget {
  List<Map<String, dynamic>> topServiceProviders;
  final bool askForRequest ;

  SPCard({
    super.key,
    required this.topServiceProviders,
    required this.askForRequest
  });

  @override
  State<SPCard> createState() => _SPCardState();
}

class _SPCardState extends State<SPCard> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: ((MediaQuery.of(context).size.width / 2) - (0)) * (widget.topServiceProviders.length / 2).ceil() * (1/1),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.topServiceProviders.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
            Get.to(SPProfilePage(askForRequest: widget.askForRequest,)) ; // you should pass the service provider id
                                                          // so we can retrieve his catalog and work exp and reviews
            },
            child: SPCardDetails(
              sPImageURL: widget.topServiceProviders[index]["UserPicture"] ??
                  "images/profilePic96.png",
              sPName: widget.topServiceProviders[index]["Username"] ?? "Default Name",
              sPPrice: (widget.topServiceProviders[index]["Price"] ?? 0).toDouble(),
              sPRating: (widget.topServiceProviders[index]["Rating"] ?? 0).toDouble(),
              sPServiceType: widget.topServiceProviders[index]["ServiceType"] ??
                  "Default Service Type",
            ),
          );
        },
      ),
    );
  }
}
