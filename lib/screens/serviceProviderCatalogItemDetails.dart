import 'dart:convert';
import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

import '../APIRequests/serviceProviderCatalogAPI.dart';
import '../Widgets/ratingBar_ServiceProvider.dart';
import '../Widgets/sp_CatalogItemDialog.dart';

import 'package:http/http.dart' as http;


// void main() {
//   runApp(MaterialApp(home: SPCatalogItem(),));
// }

class SPCatalogItem extends StatefulWidget {
  String catalogID;

  SPCatalogItem({
    super.key,
    required this.catalogID,
  });

  @override
  State<SPCatalogItem> createState() => _SPCatalogItemState();
}

class _SPCatalogItemState extends State<SPCatalogItem> {
  String itemImage = '';
  String itemName = '';
  String itemPrice = '';
  String itemDescription = '';
  double itemRating=0.0;

  List<Color> itemColors = [];
  late Map<String, dynamic> itemDetails ;
  @override
  void initState() {
    super.initState();
    setState(() {
      itemDetails = Get.arguments ;
    });
    _loadItemDetails(); // Call the method to load item details
  }

  Future<void> _loadItemDetails() async {

    setState(() {
      itemImage = itemDetails['ItemImage'] ?? '';
      itemName = itemDetails['ItemName'] ?? '';
      itemPrice = (itemDetails['ItemPrice'] ?? 0).toString();
      itemDescription = itemDetails['ItemDescription'] ?? '';
      itemRating = (itemDetails['ItemRating'] ?? 0).toDouble();

      String itemColorsJson = itemDetails['ItemColors'];

      if (itemColorsJson != null) {
        try {
          List<String> colorStrings =
          List<String>.from(json.decode(itemColorsJson));
          itemColors = colorStrings.map((colorString) {
            final sanitizedColorString = colorString.replaceAll("Color(", "").replaceAll(")", "").replaceAll("0x", "");
            final colorValue = int.parse(sanitizedColorString, radix: 16);
            return Color(colorValue);
          }).toList();
        } catch (e) {
          print("Error parsing ItemColors: $e");
          itemColors = [Colors.black]; // or another default color
        }
      } else {
        itemColors = [Colors.black]; // Default color when ItemColors is not provided.
      }

    });
  }



  Future <List<dynamic>?>  editCatalogItem()  => showDialog <List<dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return ServiceProviderCatalogItemDataDialog(
          catalogID: widget.catalogID,
          itemName: itemName,
          itemPrice: itemPrice,
          itemDescription: itemDescription,
          itemColors: itemColors,
        );
      });


  Image? image;
  String? imageUrl;
  late final pickedImage ;
  final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  Future<void> pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      setState(() {
        image = Image.file(imageFile);
      });
    }
    if (image != null) {
      final url = Uri.parse(cloudinaryUrl) ;
      final req = http.MultipartRequest('POST' , url)
        ..fields['upload_preset'] = 'buildnex'
        ..files.add(await http.MultipartFile.fromPath('file', pickedImage.path)) ;

      final response = await req.send();
      if(response.statusCode == 200){
        final responseData = await response.stream.toBytes() ;
        final responseString = String.fromCharCodes(responseData) ;
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'] ;
          imageUrl = url ;
        });
      }
    }
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
          Stack(children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Image(
                image: NetworkImage(itemImage),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: FittedBox(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () async {
                          var imageName = await pickImage();
                          setState(() {
                            itemImage = imageUrl! ;
                          });

                          /*
                            I need here api to update the image for the product
                           */
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
          ]),
          Expanded(
            child: Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 30,
              child: Container(
                width: double.infinity,
                color: Color(0xFF122247),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              itemName,
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Color(0xFFF9FAFB),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            FittedBox(
                              child: SizedBox(
                                height: 30.0,
                                width: 30.0,
                                child: FittedBox(
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      List<dynamic>? updatedData = await editCatalogItem();
                                      if (mounted) {
                                        setState(() {
                                          if (updatedData != null) {
                                            itemName = updatedData[0];
                                            itemPrice = updatedData[1];
                                            itemDescription = updatedData[2];

                                          }
                                        });
                                      }
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
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: RatingBarSB(
                          rating: itemRating,
                          size: 23,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text('${itemPrice} ILS', // Display the item price here
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF9FAFB),
                          ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Color: ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFF9FAFB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                for (int i = 0; i < itemColors.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: itemColors[i],
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xfff3fbfe)
                                                  .withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                            ),
                                          ]),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
