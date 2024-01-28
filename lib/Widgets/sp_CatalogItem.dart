import 'package:flutter/material.dart';
import '../classes/language_constants.dart';

class ServiceProvideCatalogItem extends StatefulWidget {
  String catalogItemImageURL;
  String catalogItemImageName;
  double catalogItemPrice;
  double catalogItemRating;

  ServiceProvideCatalogItem(
      {super.key,
      required this.catalogItemImageURL,
      required this.catalogItemImageName,
      required this.catalogItemPrice,
      required this.catalogItemRating});

  @override
  State<ServiceProvideCatalogItem> createState() =>
      _ServiceProvideCatalogItemState();
}

class _ServiceProvideCatalogItemState extends State<ServiceProvideCatalogItem> {
  TextStyle styleCity = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xfff3fbfe));
  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: <Widget>[
              Card(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1)),
                shadowColor: const Color(0xff26364b),
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image(
                        image: NetworkImage(widget.catalogItemImageURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.catalogItemImageName,
                  textAlign: isRtl ? TextAlign.left : TextAlign.right,
                  style: styleCity,
                ),
              ),
              Align(
                alignment: isRtl ? Alignment.topLeft : Alignment.topRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: SizedBox(
                    width: 45,
                    height: 25,
                    child: Card(
                      color: const Color(0xfff3fbfe),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1)),
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
                              widget.catalogItemRating.toString(),
                              style: const TextStyle(
                                  fontSize: 9.5,
                                  color: Color(0xFF435b83),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: isRtl ? Alignment.bottomLeft : Alignment.bottomRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: SizedBox(
                    width: 75,
                    height: 30,
                    child: Card(
                      color: const Color(0xfff3fbfe),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1)),
                      child: Center(
                        child: Text(
                          isRtl
                              ? "${widget.catalogItemPrice} شيكل"
                              : "${widget.catalogItemPrice} ILS",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF435b83),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
