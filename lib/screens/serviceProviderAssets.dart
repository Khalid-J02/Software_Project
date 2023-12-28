import 'package:buildnex/APIRequests/homeOwnerDisplayServiceProData.dart';
import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/APIRequests/serviceProviderWorkExpAPI.dart';
import 'package:buildnex/Widgets/addAssetNewItem.dart';
import 'package:buildnex/Widgets/serviceProviderAssetsItemDetails.dart';
import 'package:buildnex/Widgets/sp_AssetsItem.dart';
import 'package:buildnex/screens/serviceProviderCatalogItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  List<Map<String, dynamic>> workList = [];
  Map<String, dynamic> jsonObject = {};

  Future <List<dynamic>?> addNewItem () => showDialog <List<dynamic>>(
      context: context,
      builder: (BuildContext context){
        return AssetNewItem() ;
      }
  ) ;

  Future<void> _loadCatalogItems() async {
    try {
      final List<Map<String, dynamic>> providerWorkExp = await WorkExperienceAPI.getWorkExperiences() ;
      setState(() {
        workList = providerWorkExp;
      });
    } catch (e) {
      // Handle API call errors
      print('Error loading catalog items: $e');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCatalogItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF9FAFB),
        onPressed: () async {
          List<dynamic>? newData = await addNewItem() ;
          setState(() {
            if(newData != null){
              jsonObject = {
                "WorkImage": newData[2],
                "WorkName" : newData?[0],
                'WorkDescription' : newData[1],
                'WorkID' : newData[3]
              };
            }
            workList.add(jsonObject);
          });
        },
        child: const Icon(
          Icons.add , color: Color(0xFF122247),
          size: 25,
        ),
      ),
      body: workList.length == 0
          ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('There is no items to see here...',
              style: TextStyle(
                  color: Colors.grey[600] ,
                  fontSize: 18 , fontWeight:
              FontWeight.bold
              ),
            ),
          )
        ],
      )
          :
      GridView.builder(
        itemCount: workList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context , index){
          var ItemObject = workList[index];
          return GestureDetector(
            onTap: () async{
              final Map<String, dynamic> itemDetails = await WorkExperienceAPI.getWorkExpDetails(ItemObject["WorkID"].toString());
              Get.to(SPAssetsItem(ItemID: ItemObject["WorkID"].toString(),) , arguments:itemDetails );
            },
            child: ServiceProvideAssetsItem(catalogItemImageURL: ItemObject["WorkImage"], catalogItemImageName: ItemObject["WorkName"]),
          );
        },
      ),
    );
  }
}
