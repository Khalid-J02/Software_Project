import 'package:buildnex/Widgets/addAssetNewItem.dart';
import 'package:buildnex/Widgets/serviceProviderAssetsItemDetails.dart';
import 'package:buildnex/Widgets/sp_AssetsItem.dart';
import 'package:buildnex/screens/serviceProviderCatalogItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/addCatalogNewItem.dart';
import '../Widgets/sp_CatalogItem.dart';


void main() {
  runApp(GetMaterialApp(home: ServiceProviderAssets(),));
}

class ServiceProviderAssets extends StatefulWidget {
  const ServiceProviderAssets({super.key});

  @override
  State<ServiceProviderAssets> createState() => _ServiceProviderAssetsState();
}

class _ServiceProviderAssetsState extends State<ServiceProviderAssets> {

  List<Map<String, dynamic>> workList = [
    {
      "image": "images/Testing/Tokyo.jpg",
      "Name": "Tokyo",
    },
    {
      "image": "images/Testing/tarabzon2.jpg",
      "Name": "tarabzon2",
    },
    {
      "image": "images/Testing/Salalah2.jpg",
      "Name": "Salalah2",
    },
    {
      "image": "images/Testing/Iceland2.jpg",
      "Name": "Iceland2",
    },
    {
      "image": "images/Testing/Dubai2.jpg",
      "Name": "Dubai2",
    },
    {
      "image": "images/Testing/Bali2.jpg",
      "Name": "Bali2",
    },
    {
      "image": "images/Testing/Tokyo2.jpg",
      "Name": "Tokyo",
    },
    {
      "image": "images/Testing/Salalah.jpg",
      "Name": "Salalah",
    },
  ];

  Future <List<dynamic>?> addNewItem () => showDialog <List<dynamic>>(
      context: context,
      builder: (BuildContext context){
        return AssetNewItem() ;
      }
  ) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF9FAFB),
        onPressed: () async {
          List<dynamic>? newData = await addNewItem() ;
          setState(() {
            if(newData != null){
              Map<String, dynamic> jsonObject = {
                "image": "images/Testing/Tokyo.jpg",
                "Name" : newData?[0],
              };
              workList.add(jsonObject);
            }
          });
        },
        child: const Icon(
          Icons.add , color: Color(0xFF122247),
          size: 25,
        ),
      ),
      body: GridView.builder(
        itemCount: workList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context , index){
          var ItemObject = workList[index];
          return GestureDetector(
            onTap: (){
              Get.to(SPAssetsItem(itemImage: ItemObject["image"], itemName: ItemObject["Name"],));
            },
            child: ServiceProvideAssetsItem(catalogItemImageURL: ItemObject["image"], catalogItemImageName: ItemObject["Name"]),
          );
        },
      ),
    );
  }
}
