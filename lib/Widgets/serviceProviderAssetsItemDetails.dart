import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:buildnex/APIRequests/serviceProviderWorkExpAPI.dart';
import 'package:buildnex/Widgets/sp_AssetItemDialog.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../classes/language_constants.dart';



class SPAssetsItem extends StatefulWidget {
  String ItemID;
  SPAssetsItem({super.key, required this.ItemID
      });

  @override
  State<SPAssetsItem> createState() => _SPCatalogItemState();
}

class _SPCatalogItemState extends State<SPAssetsItem> {
  late Map<String, dynamic> itemDetails;

  Future<List<String>?> editCatalogItem() => showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return ServiceProviderAssetItemDataDialog(
          itemName: itemDetails['WorkName'],
          itemDescription: itemDetails['WorkDescription'],
          itemID: widget.ItemID.toString(),
        );
      });

  Image? image;
  String? imageUrl;
  late final pickedImage;
  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
  final String uploadPreset = 'buildnex';

  Future<void> pickImageWEB() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      if (MediaQuery.of(context).size.width > 930) {
        safeSetState;
      } else {
        setState(() {
          image = Image.file(imageFile);
        });
      }
    }
    if (image != null || pickedImage != null) {
      final url = Uri.parse(cloudinaryUrl);
      final req = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'buildnex';

      // Read the image file as bytes
      List<int> imageBytes = await pickedImage.readAsBytes();

      // Convert the image bytes to Uint8List
      Uint8List uint8List = Uint8List.fromList(imageBytes);

      // Create a MultipartFile using fromBytes
      final http.MultipartFile file =
      http.MultipartFile.fromBytes('file', uint8List, filename: 'image.jpg');

      req.files.add(file);

      final response = await req.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        setState(() {
          final url = jsonMap['url'];
          imageUrl = url;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemDetails = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          Get.offAndToNamed('/HomePage/ServiceProvider',
              arguments: {'pageIndex': 3});
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              translation(context)!.serviceProviderAssetsItemDetailsTitle,
              style: TextStyle(color: Color(0xFFF9FAFB)),
            ),
            elevation: 0,
            backgroundColor: Color(0xFF122247), //Colors.white,
          ),
          backgroundColor: Color(0xFFF9FAFB),
          body: Column(
            children: <Widget>[
              Stack(
                  children: [
                MediaQuery.of(context).size.width > 930
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.all(25),
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image(
                            image: NetworkImage(itemDetails['WorkImage']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(16),
                        child: Image(
                          image: NetworkImage(itemDetails['WorkImage']),
                          fit: BoxFit.cover,
                        )),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    child: FittedBox(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.width > 930 ? 40 : 30.0,
                        width:
                            MediaQuery.of(context).size.width > 930 ? 40 : 30.0,
                        child: FittedBox(
                          child: FloatingActionButton(
                            onPressed: () async {
                              var imageName = await pickImageWEB();
                              if (imageUrl != null) {
                                setState(() {
                                  itemDetails['WorkImage'] = imageUrl!;
                                });
                                await WorkExperienceAPI.editWorkExpImage(
                                    widget.ItemID, imageUrl!);
                              }
                            },
                            elevation: 0,
                            backgroundColor: const Color(0xfff3fbfe),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xff435b83),
                              size: MediaQuery.of(context).size.width > 930
                                  ? 40
                                  : 35.0,
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
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 50, bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itemDetails['WorkName'],
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Color(0xFFF9FAFB),
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                          List<String>? UpdatedData =
                                              await editCatalogItem();
                                          setState(() {
                                            if (UpdatedData != null) {
                                              itemDetails['WorkName'] =
                                                  UpdatedData![0];
                                              itemDetails['WorkDescription'] =
                                                  UpdatedData![1];
                                            }
                                          });
                                        },
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0xfff3fbfe),
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
                              itemDetails['WorkDescription'],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
