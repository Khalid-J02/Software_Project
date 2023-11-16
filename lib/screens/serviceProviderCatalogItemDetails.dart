import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';


import '../Widgets/ratingBar_ServiceProvider.dart';
import '../Widgets/sp_CatalogItemDialog.dart';

// void main() {
//   runApp(MaterialApp(home: SPCatalogItem(),));
// }

class SPCatalogItem extends StatefulWidget {
  String itemImage ;
  String itemName ;
  SPCatalogItem(
      {
        super.key,
        required this.itemImage,
        required this.itemName
      }
      );

  @override
  State<SPCatalogItem> createState() => _SPCatalogItemState();
}

class _SPCatalogItemState extends State<SPCatalogItem> {

  List<Color> itemColors = [
    Color(0xFF795548),
    Color(0xFFF44336),
    Color(0xffff9800),
    Color(0xffcddc39),
  ] ;

  String itemDescription = loremIpsum(words: 20) ;

  Future <List<String>?> editCatalogItem()=> showDialog <List<String>>(
      context: context,
      builder: (BuildContext context){
        return ServiceProviderCatalogItemDataDialog(itemName: widget.itemName, itemDescription: itemDescription, itemColors: itemColors,);
      }
  );

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
          Padding(
            padding: EdgeInsets.all(16),
            child: Image(
              image: AssetImage(widget.itemImage),
              fit: BoxFit.cover,
            ),
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
                      padding: const EdgeInsets.only(top: 5 , bottom: 10),
                      child: RatingBarSB(rating: 3.5 , size: 23,),
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
                                GestureDetector(
                                  onTap: (){
                                    setState(() {

                                    });
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
                                            color: Color(0xfff3fbfe).withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ],
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

