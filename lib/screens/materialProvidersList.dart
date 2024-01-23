import 'package:buildnex/Widgets/materialProviderItemList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaterialProvidersList extends StatefulWidget {
  List materialProvidersData;
  MaterialProvidersList({super.key, required this.materialProvidersData});

  @override
  State<MaterialProvidersList> createState() => _MaterialProvidersListState();
}

class _MaterialProvidersListState extends State<MaterialProvidersList> {


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
          child: widget.materialProvidersData.isEmpty
              ? const Center(
            child: Text(
              'No Material Providers Found..',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
              : ListView.builder(
            itemCount: widget.materialProvidersData.length,
            itemBuilder: (context, index) {
              var providerData = widget.materialProvidersData[index];
              var socialLink = providerData['UserProfileInfo'] ?? '';
              var displayLink = socialLink.length > 50 ? '${socialLink.substring(0, 47)}...' : socialLink;

              return MaterialProviderItem(
                name: widget.materialProvidersData[index]['Username']?? '',
                phoneNumber: widget.materialProvidersData[index]['UserPhoneNumber']?? '',
                socialLink: displayLink,
                city: widget.materialProvidersData[index]['UserCity'] ?? '',
              );
            },
          ),
        ),
      ),
    );
  }
}
