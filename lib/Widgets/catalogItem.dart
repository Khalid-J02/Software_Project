import 'dart:convert';
import 'dart:io';

import 'package:buildnex/Widgets/sp_CatalogItemDialogForReview.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';


import '../Widgets/ratingBar_ServiceProvider.dart';


class SPCatalogItem_HO extends StatefulWidget {
  Map<String, dynamic> itemDetails;

  SPCatalogItem_HO(
      {
        super.key,
        required this.itemDetails
      }
      );

  @override
  State<SPCatalogItem_HO> createState() => _SPCatalogItemState();
}

class _SPCatalogItemState extends State<SPCatalogItem_HO> {

  List<Color> itemColors = [] ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      String itemColorsJson = widget.itemDetails['ItemColors'];

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
          itemColors = [Colors.black]; // or another default color
        }
      } else {
        itemColors = [Colors.black]; // Default color when ItemColors is not provided.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          //projectName,
          "Back",
          style: TextStyle(color: Color(0xFFF9FAFB)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),

      backgroundColor: Color(0xFFF9FAFB),
      body: Column(
        // shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Image(
              image: NetworkImage(widget.itemDetails['ItemImage']),
              fit: BoxFit.cover,
            ),
          ),
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
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(widget.itemDetails['ItemName'],
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Color(0xFFF9FAFB),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Text(
                                    "${widget.itemDetails['ItemPrice']} ILS",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFFF9FAFB),
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      if(widget.itemDetails['ItemRating'] != 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 5 , bottom: 10),
                          child: RatingBarSB(rating: widget.itemDetails['ItemRating'] , size: 23,),
                        ),
                      if(widget.itemDetails['ItemRating'] == 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 5 , bottom: 10),
                          child: RatingBarSB(rating: 0.0 , size: 23,),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12 , horizontal: 8),
                        child: Text(
                          widget.itemDetails['ItemDescription'],
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
                            const Text("Color: ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFF9FAFB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12,),
                            Row(
                              children: [
                                for(int i = 0; i < itemColors.length ; i++)
                                  Container(
                                    height: 25,
                                    width: 25,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: itemColors[i],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                              ],
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

