import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/classes/language_constants.dart';
import 'package:buildnex/screens/sPProfilePage_HO.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ho_serviceProviderCard.dart';

class SPCard extends StatefulWidget {
  List<Map<String, dynamic>> topServiceProviders;
  final bool askForRequest ;
  String? taskID ;

  SPCard({
    super.key,
    required this.topServiceProviders,
    required this.askForRequest,
    this.taskID,
  });

  @override
  State<SPCard> createState() => _SPCardState();
}

class _SPCardState extends State<SPCard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.taskID) ;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width > 930
            ? ((MediaQuery.of(context).size.width / 5) - (0)) * (widget.topServiceProviders.length / 5).ceil() * (1/1)
            : ((MediaQuery.of(context).size.width / 2) - (0)) * (widget.topServiceProviders.length / 2).ceil() * (1/1),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.topServiceProviders.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 930
                ? 5
                : 2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async{
                final Map<String, dynamic> bestServiceProviders =  await ServiceProviderDataAPI.getServiceProData(widget.topServiceProviders[index]["UserID"].toString());
                final List<Map<String, dynamic>> providerCatalog = await ServiceProviderDataAPI.getServiceProCatalogItems(widget.topServiceProviders[index]["UserID"].toString()) ;
                final List<Map<String, dynamic>> providerWorkExp = await ServiceProviderDataAPI.getServiceProWorkExperiences(widget.topServiceProviders[index]["UserID"].toString()) ;
                final List<Map<String, dynamic>> providerReviews = await ServiceProviderDataAPI.getServiceProReviews(widget.topServiceProviders[index]["UserID"].toString()) ;

                Get.to(SPProfilePage(
                  askForRequest: widget.askForRequest,
                  serviceProviderName: widget.topServiceProviders[index]["Username"],
                  serviceProviderType: widget.topServiceProviders[index]["ServiceType"],
                  serviceProviderImage: widget.topServiceProviders[index]["UserPicture"],
                  serviceProviderRating: (widget.topServiceProviders[index]["Rating"] ?? 0).toDouble(),
                  bestServiceProviders: bestServiceProviders,
                  providerCatalog: providerCatalog,
                  providerWorkExp: providerWorkExp,
                  providerReviews: providerReviews,
                ) ,
                  arguments: {
                      'taskId' : widget.taskID,
                      'serviceProviderID' : widget.topServiceProviders[index]["UserID"].toString(),
                    }) ; // you should pass the service provider id
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
      ),
    );
  }
}
