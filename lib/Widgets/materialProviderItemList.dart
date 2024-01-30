import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class MaterialProviderItem extends StatefulWidget {
  String name ;
  String phoneNumber ;
  String socialLink ;
  String city ;
  MaterialProviderItem(
      {
        super.key,
        required this.name,
        required this.phoneNumber,
        required this.socialLink,
        required this.city
      }
  );

  @override
  State<MaterialProviderItem> createState() => _MaterialProviderItemState();
}

class _MaterialProviderItemState extends State<MaterialProviderItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 4),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF6781A6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    widget.name,
                    maxLines: 3,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 21,
                      color: Color(0xFFF3D69B),
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  flex: 3,
                  child: Text(
                    " - ${widget.city}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF3D69B),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final url = Uri(scheme: 'tel' , path: widget.phoneNumber) ;
                if(await canLaunchUrl(url)){
                  launchUrl(url) ;
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.call,
                      color: Color(0xFFF9FAFB),
                      // color: Color(0xFFF9FAFB),
                      size: 18,
                    ),
                    const SizedBox(width: 6,),
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFFF9FAFB),
                        //color: Color(0xFFF9FAFB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0 , bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.link,
                    color: Color(0xFFF9FAFB),
                    size: 18,
                  ),
                  const SizedBox(width: 6,),
                  Expanded(
                    child: Link(
                      uri: Uri.parse(widget.socialLink),
                      target: LinkTarget.defaultTarget,
                      builder: (context, openLink) => GestureDetector(
                        onTap: openLink,
                        child: Text(
                          widget.socialLink,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFF9FAFB),
                          ),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
