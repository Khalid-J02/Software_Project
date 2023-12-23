import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:buildnex/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AssetNewItem extends StatefulWidget {
  const AssetNewItem({super.key});

  @override
  State<AssetNewItem> createState() => _AssetNewItemState();
}

class _AssetNewItemState extends State<AssetNewItem> {


  final _ItemName = TextEditingController();
  final _itemDescription = TextEditingController();

  String itemImageText = "Item Image : " ;

  TextStyle ElevatedButtonTextStyle(){
    return TextStyle(
        color: Color(0xFFF3D69B),
        fontSize: 16,
        fontWeight: FontWeight.normal
    );
  }
  ButtonStyle ElevatedButtonStyle(){
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF6781A6)),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateProperty.all(BorderSide(color: Color(0xFFF3D69B), width: 1)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        alignment: Alignment.center
    ) ;
  }

  File? file ;
  ImagePicker image = ImagePicker() ;

  pickImageFromGallery() async{
    var img = await image.pickImage(source: ImageSource.gallery) ;
    setState(() {
      if(img != null){
        file =File(img!.path) ;
      }
    });
  }

  void _saveData() {
    List<dynamic> data = [
      _ItemName.text,
      _itemDescription.text,
      file
    ];
    Navigator.of(context).pop(data);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF2F4771),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 450,
          width: 300,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text("Add New Catalog Item",
                  style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFF3D69B)
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12 ,),
                child: Textfield(controller: _ItemName, hintText: "Enter Item Name", labelText: "Item Name"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12 , ),
                child: Textfield(controller: _itemDescription, hintText: "Enter Item Description", labelText: "Item Description"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      itemImageText,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFFF3D69B)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                        onPressed: () async{
                          var imageName = await pickImageFromGallery() ;
                        },
                        style: ElevatedButtonStyle(),
                        child: Icon(Icons.add_a_photo_rounded , color: Color(0xFFF3D69B), size: 20,),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0 , bottom: 12 ),
                height: 150,
                width: 150,
                child: file == null ?
                const Icon(
                  Icons.image,
                  size: 35,
                  color: Color(0xFFF3D69B),
                )
                    : Image.file(
                  file!,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top : 8.0),
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
                        onPressed: (){
                          _saveData();
                        } ,
                        child: const Text(
                          'Add',
                          style: TextStyle(
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
                        child: const Text(
                          'Cancel',
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

    );
  }
}
