import 'package:flutter/material.dart';

import 'ho_serviceProviderCard.dart';

class SPCard extends StatefulWidget {
  List<Map<String, dynamic>> topServiceProviders;

  SPCard({
    super.key,
    required this.topServiceProviders,
  });

  @override
  State<SPCard> createState() => _SPCardState();
}

class _SPCardState extends State<SPCard> {
  @override
  Widget build(BuildContext context) {
    print('Top Service Providers: ${widget.topServiceProviders}');

    return GridView.builder(
      itemCount: widget.topServiceProviders.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
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
    );
  }
}
