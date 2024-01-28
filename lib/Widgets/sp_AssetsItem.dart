import 'package:flutter/material.dart';
import '../classes/language_constants.dart';

class ServiceProvideAssetsItem extends StatefulWidget {
  String catalogItemImageURL;
  String catalogItemImageName;

  ServiceProvideAssetsItem({
    super.key,
    required this.catalogItemImageURL,
    required this.catalogItemImageName,
  });

  @override
  State<ServiceProvideAssetsItem> createState() =>
      _ServiceProvideCatalogItemState();
}

class _ServiceProvideCatalogItemState extends State<ServiceProvideAssetsItem> {
  TextStyle styleCity = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xfff3fbfe));
  @override
  Widget build(BuildContext context) {
    var isRtl = Localizations.localeOf(context).languageCode == 'ar';
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
                padding: EdgeInsets.all(15.0),
                child: Text(
                  widget.catalogItemImageName,
                  textAlign: isRtl ? TextAlign.left : TextAlign.right,
                  style: styleCity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
