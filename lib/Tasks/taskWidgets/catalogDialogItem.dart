import 'package:buildnex/Widgets/catalogItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../screens/projectNav_homeOwner.dart';

class CatalogDialogItem extends StatefulWidget {
  final String itemName ;
  final String itemImage ;
  final double itemRating ;

  const CatalogDialogItem(
      {
        super.key,
        required this.itemName,
        required this.itemImage,
        required this.itemRating
      }
  );

  @override
  State<CatalogDialogItem> createState() => _CatalogDialogItemState();
}

class _CatalogDialogItemState extends State<CatalogDialogItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Color(0xFF6781A6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFF3D69B),
              width: 1,
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      height: 80,
                      width: 80,
                      child: Card(
                        shape:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.transparent, width: 1)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)) ,
                          child: Image(
                            image: AssetImage(widget.itemImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            widget.itemName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: widget.itemRating,
                          itemSize: 15,
                          unratedColor: Colors.grey,
                          itemBuilder: (_, __) => Icon(Icons.star , color: Color(0xFFF3D69B),),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(Icons.navigate_next , size: 30, color: Color(0xFFF3D69B),),
                onPressed: () {
                  Get.to(SPCatalogItem_HO(itemDetails: {},));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
