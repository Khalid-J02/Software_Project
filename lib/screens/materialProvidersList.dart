import 'package:buildnex/Widgets/materialProviderItemList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialProvidersList extends StatefulWidget {
  const MaterialProvidersList({super.key});

  @override
  State<MaterialProvidersList> createState() => _MaterialProvidersListState();
}

class _MaterialProvidersListState extends State<MaterialProvidersList> {

  List materialProvidersData = [
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
    {
      "name" : "company x",
      "city" : "Nablus",
      "phoneNumber" : "0592685190",
      "socialLink" : "https://www.facebook.com/"
    },
  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.group,
          color: Color(0xFFF3D69B),
        ),
        title: const Text(
          //projectName,
          "Material Providers",
          style: TextStyle(color: Color(0xFFF3D69B)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247), //Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFF2F4771),
          child: ListView.builder(
            itemCount: materialProvidersData.length,
            itemBuilder: (context , index){
              return MaterialProviderItem(
                name: materialProvidersData[index]['name'],
                phoneNumber: materialProvidersData[index]['phoneNumber'],
                socialLink: materialProvidersData[index]['socialLink'],
                city: materialProvidersData[index]['city'],
              );
            },
          ),
        ),
      ),
    );
  }
}
