import 'dart:io';

import 'package:buildnex/Widgets/sp_AssetItemDialog.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';


import '../Widgets/ratingBar_ServiceProvider.dart';
import '../Widgets/sp_CatalogItemDialog.dart';

// void main() {
//   runApp(MaterialApp(home: SPCatalogItem(),));
// }

class SPAssetsItem extends StatefulWidget {
  String itemImage ;
  String itemName ;
  SPAssetsItem(
      {
        super.key,
        required this.itemImage,
        required this.itemName
      }
      );

  @override
  State<SPAssetsItem> createState() => _SPCatalogItemState();
}

class _SPCatalogItemState extends State<SPAssetsItem> {

  String itemDescription = loremIpsum(words: 20) ;

  Future <List<String>?> editCatalogItem()=> showDialog <List<String>>(
      context: context,
      builder: (BuildContext context){
        return ServiceProviderAssetItemDataDialog(itemName: widget.itemName, itemDescription: itemDescription);
      }
  );

  File? file ;
  ImagePicker image = ImagePicker() ;

  pickImageFromGallery() async{
    var img = await image.pickImage(source: ImageSource.gallery) ;
    setState(() {
      if(img != null){
        file =File(img!.path) ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFFF9FAFB),
        ),
        title: const Text(
          //projectName,
          "Back",
          style: TextStyle(color: Color(0xFFF9FAFB)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),

      backgroundColor: Color(0xFFF9FAFB),
      body: ListView(
        children: <Widget>[
          Stack(
              children:[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: file == null ?
                  Image(
                    image: AssetImage(widget.itemImage),
                    fit: BoxFit.cover,
                  )
                      :
                  Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),
                    child: FittedBox(
                      child: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: FittedBox(
                          child: FloatingActionButton(
                            onPressed: () async{
                              var imageName = await pickImageFromGallery() ;
                            },
                            elevation: 0,
                            backgroundColor: const Color(0xfff3fbfe),

                            child: const Icon(
                              Icons.edit,
                              color: Color(0xff435b83),
                              size: 35.0,

                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFF122247),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 10),
                      child: Row(
                        children: [
                          Text(widget.itemName,
                            style: const TextStyle(
                                fontSize: 28,
                                color: Color(0xFFF9FAFB),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 15,),
                          FittedBox(
                            child: SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    List<String>? UpdatedData = await editCatalogItem();
                                    setState(() {
                                      if(UpdatedData != null){
                                        widget.itemName = UpdatedData![0];
                                        itemDescription = UpdatedData![1];
                                      }
                                    });
                                  },
                                  elevation: 0,
                                  backgroundColor: const Color(0xfff3fbfe),

                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xff435b83),
                                    size: 35.0,

                                  ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        itemDescription,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFFF9FAFB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

