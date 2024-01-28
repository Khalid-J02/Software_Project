import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:buildnex/Widgets/TextField.dart';
import 'package:buildnex/Widgets/newItemColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../APIRequests/serviceProviderCatalogAPI.dart';
import '../classes/language_constants.dart';
import 'customAlertDialog.dart';
import 'package:http/http.dart' as http;

class CatalogNewItem extends StatefulWidget {
  const CatalogNewItem({super.key});

  @override
  State<CatalogNewItem> createState() => _CatalogNewItemState();
}

class _CatalogNewItemState extends State<CatalogNewItem> {
  late int catalogItemId;
  final _ItemName = TextEditingController();
  final _itemDescription = TextEditingController();
  final _itemPrice = TextEditingController();

  List<Color> itemColors = [];

  TextStyle ElevatedButtonTextStyle() {
    return TextStyle(
        color: Color(0xFFF3D69B), fontSize: 16, fontWeight: FontWeight.normal);
  }

  ButtonStyle ElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(
            BorderSide(color: Color(0xFFF3D69B), width: 1)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        alignment: Alignment.center);
  }

  void _addColor(Color color) {
    setState(() {
      itemColors.add(color);
    });
  }

  void _removeColor(int index) {
    setState(() {
      itemColors.removeAt(index);
    });
  }

  void _openColorPicker() async {
    var chosenColor = await showDialog<List<Color>>(
      context: context,
      builder: (context) => NewItemColorPicker(),
    );

    if (chosenColor != null) {
      _addColor(chosenColor[0]);
    }
  }

  Image? image;
  String? imageUrl;
  late final pickedImage;
  final String cloudinaryUrl =
      'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
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
      final url = Uri.parse(cloudinaryUrl);
      final req = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'buildnex'
        ..files
            .add(await http.MultipartFile.fromPath('file', pickedImage.path));

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

  Future<bool> _validateFields() async {
    final String itemNameAPI = _ItemName.text;
    final String itemDescriptionAPI = _itemDescription.text;
    final String itemPriceAPI = _itemPrice.text;
    List<String> itemColorsAPI = itemColors.map((color) {
      return 'Color(0x${color.value.toRadixString(16)})';
    }).toList();

    if (itemNameAPI.isEmpty ||
        itemDescriptionAPI.isEmpty ||
        itemPriceAPI.isEmpty ||
        itemColorsAPI.isEmpty ||
        imageUrl == null) {
      //|| itemImageAPI == null


      CustomAlertDialog.showErrorDialog(
          context, translation(context)!.customFill);
      return false;
    } else {
      // Check if itemPriceAPI is a valid numeric string
      if (double.tryParse(itemPriceAPI) == null) {
        CustomAlertDialog.showErrorDialog(context, translation(context)!.customInvalidPrice);
        return false;
      }

      catalogItemId = await CatalogAPI.addItemToCatalog(
        itemNameAPI,
        imageUrl!,
        double.parse(itemPriceAPI),
        itemDescriptionAPI,
        itemColorsAPI,
      );
      return true;
    }
  }

  Future<void> _saveData() async {
    if (await _validateFields()) {
      List<dynamic> data = [
        _ItemName.text,
        _itemDescription.text,
        double.parse(_itemPrice.text),
        itemColors,
        imageUrl,
        catalogItemId
      ];

      Navigator.of(context).pop(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: translation(context)!.localeName == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr,
    child:  AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  translation(context)!.addCatalogNewItemMainTitle,
                  style: const TextStyle(fontSize: 22, color: Color(0xFFF3D69B)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 4.0, bottom: 8.0),
                child: Textfield(
                    controller: _ItemName,
                    hintText:  translation(context)!.addCatalogNewItemItemNameHint,
                    labelText:  translation(context)!.addCatalogNewItemItemNameLabel,),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 8.0, bottom: 8.0),
                child: Textfield(
                    controller: _itemDescription,
                    hintText: translation(context)!.addCatalogNewItemItemDesHint,
                    labelText: translation(context)!.addCatalogNewItemItemDesLabel),
              ),
              Padding(
                padding: const EdgeInsets.only( top: 8.0, bottom: 8.0),
                child: Textfield(
                    controller: _itemPrice,
                    hintText: translation(context)!.addCatalogNewItemItemPriceHint,
                    labelText: translation(context)!.addCatalogNewItemItemPriceLabel),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, right: 8),
                child: Row(
                  children: [
                     Text(
                    translation(context)!.addCatalogNewItemColor,
                      style: const TextStyle(fontSize: 18, color: Color(0xFFF3D69B)),
                    ),
                    Container(
                      width: 200,
                      height: 25,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: itemColors.length + 1,
                        itemBuilder: (context, index) {
                          if (index == itemColors.length) {
                            return GestureDetector(
                              onTap: _openColorPicker,
                              child: Container(
                                width: 25,
                                height: 25,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xfff3fbfe),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: _openColorPicker,
                              onLongPress: () => _removeColor(index),
                              child: Container(
                                height: 25,
                                width: 25,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: itemColors[index],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context)!.addCatalogNewItemItemImageText,
                      style: const TextStyle(
                          fontSize: 18, color: Color(0xFFF3D69B)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var imageName = await pickImage();
                        },
                        style: ElevatedButtonStyle(),
                        child: const Icon(
                          Icons.add_a_photo_rounded,
                          color: Color(0xFFF3D69B),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0, bottom: 12),
                height: 150,
                width: 150,
                child: imageUrl == null
                    ? const Icon(
                        Icons.image,
                        size: 35,
                        color: Color(0xFFF3D69B),
                      )
                    : Image.network(
                        imageUrl!,
                        fit: BoxFit.fill,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _saveData();
                        },
                        child:  Text(
                          translation(context)!.addCatalogNewItemAddButton,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3D69B),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text(
                          translation(context)!.addCatalogNewItemCancelButton,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF122247),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
