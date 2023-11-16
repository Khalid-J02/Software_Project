import 'package:buildnex/screens/serviceProviderCatalogItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/sp_CatalogItem.dart';

class ServiceProviderCatalog extends StatefulWidget {
  const ServiceProviderCatalog({super.key});

  @override
  State<ServiceProviderCatalog> createState() => _ServiceProviderCatalogState();
}

class _ServiceProviderCatalogState extends State<ServiceProviderCatalog> {

  List<Map<String, dynamic>> jsonList = [
    {
      "image": "images/Testing/Tokyo.jpg",
      "Name": "Tokyo",
      "price": 25.0,
      "rating" : 2.8
    },
    {
      "image": "images/Testing/tarabzon2.jpg",
      "Name": "tarabzon2",
      "price": 35.0,
      "rating" : 4.8
    },
    {
      "image": "images/Testing/Salalah2.jpg",
      "Name": "Salalah2",
      "price": 25.0,
      "rating" : 3.5
    },
    {
      "image": "images/Testing/Iceland2.jpg",
      "Name": "Iceland2",
      "price": 25.0,
      "rating" : 2.1
    },
    {
      "image": "images/Testing/Dubai2.jpg",
      "Name": "Dubai2",
      "price": 25.0,
      "rating" : 1.9
    },
    {
      "image": "images/Testing/Bali2.jpg",
      "Name": "Bali2",
      "price": 25.0,
      "rating" : 3.2
    },
    {
      "image": "images/Testing/Tokyo2.jpg",
      "Name": "Tokyo",
      "price": 25.0,
      "rating" : 4.1
    },
    {
      "image": "images/Testing/Salalah.jpg",
      "Name": "Salalah",
      "price": 25.0,
      "rating" : 5.0
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: jsonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context , index){
          var ItemObject = jsonList[index];
          return GestureDetector(
              onTap: (){
                Get.to(SPCatalogItem(itemImage: ItemObject["image"], itemName: ItemObject["Name"],));
              },
              child: ServiceProvideCatalogItem(catalogItemImageURL: ItemObject["image"], catalogItemImageName: ItemObject["Name"], catalogItemPrice: ItemObject["price"], catalogItemRating: ItemObject["rating"],)

          );
        },
      ),
    );
  }
}
