import 'dart:convert';
import 'dart:io';
import 'package:buildnex/APIRequests/serviceProviderWorkExpAPI.dart';
import 'package:path/path.dart' as path;
import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../classes/language_constants.dart';
import 'customAlertDialog.dart';

class AssetNewItem extends StatefulWidget {
  const AssetNewItem({super.key});

  @override
  State<AssetNewItem> createState() => _AssetNewItemState();
}

class _AssetNewItemState extends State<AssetNewItem> {
  final _ItemName = TextEditingController();
  final _itemDescription = TextEditingController();
  late int workId;

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

    if (itemNameAPI.isEmpty || itemDescriptionAPI.isEmpty || imageUrl == null) {
      CustomAlertDialog.showErrorDialog(
          context, translation(context)!.customFill);
      return false;
    } else {
      workId = await WorkExperienceAPI.addWorkExperience(
        imageUrl!,
        itemNameAPI,
        itemDescriptionAPI,
      );
      return true;
    }
  }

  Future<void> _saveData() async {
    if (await _validateFields()) {
      List<dynamic> data = [
        _ItemName.text,
        _itemDescription.text,
        imageUrl,
        workId,
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
      child: AlertDialog(
        backgroundColor: Color(0xFF2F4771),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 490,
            width: 300,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    translation(context)!.addAssetNewItemMainTitle,
                    style: TextStyle(fontSize: 22, color: Color(0xFFF3D69B)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Textfield(
                      controller: _ItemName,
                      hintText:
                          translation(context)!.addAssetNewItemItemNameHint,
                      labelText:
                          translation(context)!.addAssetNewItemItemNameLabel),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Textfield(
                      controller: _itemDescription,
                      hintText:
                          translation(context)!.addAssetNewItemItemDesHint,
                      labelText:
                          translation(context)!.addAssetNewItemItemDesLabel),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translation(context)!.addAssetNewItemItemImageText,
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
                  padding: const EdgeInsets.only(top: 8.0),
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
                          onPressed: () async {
                            _saveData();
                          },
                          child: Text(
                            translation(context)!.addAssetNewItemAddButton,
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
                          child: Text(
                            translation(context)!.addAssetNewItemCancelButton,
                            style: const TextStyle(
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
