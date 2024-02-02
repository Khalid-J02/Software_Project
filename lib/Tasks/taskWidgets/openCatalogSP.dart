import 'package:buildnex/APIRequests/serviceProviderCatalogAPI.dart';
import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:buildnex/Widgets/sp_CatalogItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenCatalogSP extends StatefulWidget {
  const OpenCatalogSP({super.key});

  @override
  State<OpenCatalogSP> createState() => _OpenCatalogSPState();
}

class _OpenCatalogSPState extends State<OpenCatalogSP> {

  late List<Map<String, dynamic>> getServiceProCatalogItems ;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getServiceProCatalogItems = Get.arguments ;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Back",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SafeArea(
        child: Container(
          child: getServiceProCatalogItems.length == 0
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
            itemCount: getServiceProCatalogItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 930
              ? 5
              : 2,
            ),
            itemBuilder: (context , index){
              var ItemObject = getServiceProCatalogItems[index];
              return GestureDetector(
                  onTap: () async {
                    final Map<String, dynamic> itemDetails = await CatalogAPI.getItemDetails(ItemObject["CatalogID"].toString());
                    Get.to(SPCatalogItem_HO(itemDetails: itemDetails,));
                  },
                  onLongPress: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color(0xff1C437A),
                          title: Text("Confirmation" , style: TextStyle(color: Colors.white),),
                          content: Text("Do you want to choose this item?" , style: TextStyle(color: Colors.white),),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xffF3D69B), // Set background color to yellow
                              ),
                              onPressed: () => Navigator.pop(context, false), // Cancel
                              child: Text("Cancel" ,style: TextStyle(color: Colors.black),),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xffF3D69B), // Set background color to yellow
                              ),
                              onPressed: () => Navigator.pop(context, true), // Save
                              child: Text("Save" ,style: TextStyle(color: Colors.black),),
                            ),
                          ],
                        );
                      },
                    ).then((value) {
                      if (value == true) {
                        /*
                        here we should save the catalog id value in the db
                         */
                        Get.back(result: ItemObject["CatalogID"]);
                      }
                    });
                  },
                  child: ServiceProvideCatalogItem(catalogItemImageURL: ItemObject["ItemImage"], catalogItemImageName: ItemObject["ItemName"], catalogItemPrice: ItemObject["ItemPrice"].toDouble(), catalogItemRating: ItemObject["ItemRating"].toDouble(),)

              );
            },
          ),
        ),
      ),
    );

  }
}
