import 'package:buildnex/screens/serviceProviderCatalogItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../APIRequests/serviceProviderCatalogAPI.dart';
import '../Widgets/addCatalogNewItem.dart';
import '../Widgets/sp_CatalogItem.dart';

class ServiceProviderCatalog extends StatefulWidget {
  const ServiceProviderCatalog({super.key});

  @override
  State<ServiceProviderCatalog> createState() => _ServiceProviderCatalogState();
}

class _ServiceProviderCatalogState extends State<ServiceProviderCatalog> {

  List<Map<String, dynamic>> jsonList = [];


  @override
  void initState() {
    super.initState();
    _loadCatalogItems();
  }

  Future<void> _loadCatalogItems() async {
    try {
      final fetchedCatalogItems = await CatalogAPI.getCatalogItems();
      setState(() {
        jsonList = fetchedCatalogItems;
      });
    } catch (e) {
      // Handle API call errors
      print('Error loading catalog items: $e');
    }
  }

  Future <List<dynamic>?> addNewItem () => showDialog <List<dynamic>>(
      context: context,
      builder: (BuildContext context){
        return CatalogNewItem() ;
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
                "ItemImage": newData[4], //"images/Testing/Tokyo.jpg",
                "ItemName" : newData[0],
                "ItemPrice": newData[2],
                "ItemRating": 0.0,
                "CatalogID":newData[5]
              };
              jsonList.add(jsonObject);
            }
          });
        },
        child: const Icon(
          Icons.add , color: Color(0xFF122247),
          size: 25,
        ),
      ),
      body: GridView.builder(
        itemCount: jsonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context , index){
          var ItemObject = jsonList[index];
          return GestureDetector(
              onTap: (){
                Get.to(() => (SPCatalogItem(catalogID : ItemObject["CatalogID"].toString())));
              },
              child: ServiceProvideCatalogItem(catalogItemImageURL: ItemObject["ItemImage"].toString(), catalogItemImageName: ItemObject["ItemName"], catalogItemPrice: ItemObject["ItemPrice"].toDouble(), catalogItemRating: ItemObject["ItemRating"].toDouble(),)

          );
        },
      ),
    );
  }
}
