import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMaterialProvider extends StatefulWidget {
  const AddMaterialProvider({super.key});

  @override
  State<AddMaterialProvider> createState() => _AddMaterialProviderState();
}

class _AddMaterialProviderState extends State<AddMaterialProvider> {
  @override
  Widget build(BuildContext context) {
    final fncontroller = TextEditingController();
    String _dropDownValue = 'Hello';

    ButtonStyle ElevatedButtonStyle() {
      return ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xFF2F4771),),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
              BorderSide(color: Color(0xFFF3D69B), width: 1)),
          alignment: Alignment.center);
    }

    Image? image;
    String? imageUrl;
    late final pickedImage ;
    final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/df1qhofpr/upload';
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
        final url = Uri.parse(cloudinaryUrl) ;
        final req = http.MultipartRequest('POST' , url)
          ..fields['upload_preset'] = 'buildnex'
          ..files.add(await http.MultipartFile.fromPath('file', pickedImage.path)) ;

        final response = await req.send();
        if(response.statusCode == 200){
          final responseData = await response.stream.toBytes() ;
          final responseString = String.fromCharCodes(responseData) ;
          final jsonMap = jsonDecode(responseString);
          setState(() {
            final url = jsonMap['url'] ;
            imageUrl = url ;
          });
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.person_add_rounded , color: Color(0xFFF3D69B),),
          title: const Text(
            'Add Material Provider',
            style: TextStyle(
                color: Color(0xFFF3D69B)
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF122247),//Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: const Text(
                "Enter the following fields :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF122247),
                ),
              ),
            ),
            if(imageUrl == null)
              Container(
                height: 210 ,
                child: Center(
                  child: Icon(Icons.image , color: Color(0xFFF3D69B), size: 35,),
                ),
              ),
            if (imageUrl != null)
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4),
                height: 210,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(30),
                    child: pickedImage == null
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
                ),
              ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  var imageName = await pickImage();
                },
                style: ElevatedButtonStyle(),
                child: const Text(
                  "Pick Picture",
                  style: TextStyle(
                    color: Color(0xFFF3D69B),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Company Name:",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF122247),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 70,
                    padding: MediaQuery.of(context).size.width > 930
                        ?
                    EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                        :
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: TextFormField(
                      controller: fncontroller,
                      style: TextStyle(color: Color(0xFFF3D69B)),
                      decoration: InputDecoration(
                        hintText: 'Enter here..',
                        hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                        filled: true,
                        fillColor: Color(0xFF2F4771),
                        labelStyle: const TextStyle(
                          color: Color(0xFFF3D69B),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Address : ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF122247),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 70,
                    padding: MediaQuery.of(context).size.width > 930
                        ?
                    EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                        :
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: TextFormField(
                      controller: fncontroller,
                      style: TextStyle(color: Color(0xFFF3D69B)),
                      decoration: InputDecoration(
                        hintText: 'Enter here..',
                        hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                        filled: true,
                        fillColor: Color(0xFF2F4771),
                        labelStyle: const TextStyle(
                          color: Color(0xFFF3D69B),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Social Link : ",
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF122247),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 70,
                    padding: MediaQuery.of(context).size.width > 930
                        ?
                    EdgeInsets.only(top: 10, bottom: 10 , right: MediaQuery.of(context).size.width/3.5 , left: MediaQuery.of(context).size.width/3.5)
                        :
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: TextFormField(
                      controller: fncontroller,
                      style: TextStyle(color: Color(0xFFF3D69B)),
                      decoration: InputDecoration(
                        hintText: 'Enter here..',
                        hintStyle: TextStyle(color: Color(0xFFF3D69B)),
                        filled: true,
                        fillColor: Color(0xFF2F4771),
                        labelStyle: const TextStyle(
                          color: Color(0xFFF3D69B),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFF3D69B),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
