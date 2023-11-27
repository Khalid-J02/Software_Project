import 'package:flutter/material.dart';

class SPCardDetails extends StatefulWidget {
  String sPImageURL ;
  String sPName ;
  String sPServiceType ;
  double sPPrice ;
  double sPRating ;

  SPCardDetails(
      {
        super.key,
        required this.sPImageURL,
        required this.sPName,
        required this.sPServiceType,
        required this.sPPrice,
        required this.sPRating
      }
  );

  @override
  State<SPCardDetails> createState() => _SPCardDetailsState();
}

class _SPCardDetailsState extends State<SPCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: PhysicalModel(
        color: const Color(0xFFF9FAFB),
        elevation: 5.0, // Set the elevation
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  // width: 190,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(widget.sPImageURL),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12 , bottom: 2),
                  child: Text(
                    widget.sPName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF022D6B)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12 , bottom: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.perm_identity_sharp,
                        size: 18,
                        color: Color(0xFF022D6B),
                      ),
                      Text(
                        widget.sPServiceType,
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xFF022D6B)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12 , bottom: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.paid,
                        size: 14,
                        color: Color(0xFF022D6B),
                      ),
                      Text(
                        " ${widget.sPPrice}",
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xFF022D6B)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  child: SizedBox(
                    width: 45,
                    height: 25,
                    child: Card(
                      color: const Color(0xfff3fbfe),
                      shape:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.transparent, width: 1)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Color(0xffffc841),
                            ),
                            Text(
                              widget.sPRating.toString(),
                              style: const TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFF435b83),
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ) ,
            ]
          ),
        ),
      ),
    );
  }
}
