import 'package:flutter/material.dart';

import 'ho_serviceProviderCard.dart';

class SPCard extends StatefulWidget {

  List<Map<String, dynamic>> topServiceProviders ;

  SPCard(
      {
        super.key,
        required this.topServiceProviders,
      }
  );

  @override
  State<SPCard> createState() => _SPCardState();
}

class _SPCardState extends State<SPCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.topServiceProviders.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context , index) {
        return GestureDetector(
          onTap: (){},
          child: SPCardDetails(sPImageURL: widget.topServiceProviders[index]["image"], sPName: widget.topServiceProviders[index]["Name"], sPPrice: widget.topServiceProviders[index]["price"], sPRating: widget.topServiceProviders[index]["rating"], sPServiceType: widget.topServiceProviders[index]["service"],),
        );
      },
    );
  }
}
