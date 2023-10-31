
import 'package:buildnex/Widgets/serviceProviderData.dart';
import 'package:buildnex/Widgets/serviceProviderProfileDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MaterialApp(home: const ServiceProviderProfilePage()));
}

class ServiceProviderProfilePage extends StatefulWidget {
  const ServiceProviderProfilePage({super.key});

  @override
  State<ServiceProviderProfilePage> createState() => _ServiceProviderProfilePageState();
}

class _ServiceProviderProfilePageState extends State<ServiceProviderProfilePage> {

  String userName = 'Khalid Ahmad Jabr';
  String userRole = 'Electricity Service Provider' ;

  String userEmail = 'khalid.asej6@gmail.com';
  String userBio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id risus ac turpis vehicula lacinia. Proin auctor varius mi, ac auctor leo laoreet ac. Vestibulum quis felis nec odio rhoncus ullamcorper. Quisque tincidunt bibendum sapien, at scelerisque massa lacinia vel. Sed ac eros nec justo fermentum tincidunt. Suspendisse potenti. ' ;
  String userPhoneNum = '+972 59-258-5190';

  double userRating = 3.9 ;
  int userPrice = 39 ;

  Future <List<String>?> editProfile()=> showDialog <List<String>>(
      context: context,
      builder: (BuildContext context){
        return ServiceProviderProfileDataDialog(phoneNumber: userPhoneNum, eMail: userEmail, bio: userBio, pricePerHour: userPrice);
      }
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: const Color(0xFF122247),
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              List<String>? UpdatedData = await editProfile();
                              setState(() {
                                if(UpdatedData != null){
                                  userPhoneNum = UpdatedData![0];
                                  userEmail = UpdatedData![1];
                                  userBio = UpdatedData![2];
                                  userPrice = int.parse(UpdatedData![3]);
                                }
                              });
                            },
                            child: const Icon(Icons.edit, color: Color(0xFFF3D69B),),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: const Color(0xFF2F4771),
                      width: MediaQuery.of(context).size.width,
                      child:SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ServiceProviderData(userName: userName, userEmail: userEmail , userRole: userRole, userBio: userBio, userPhone: userPhoneNum, userPrice: userPrice, userRating: userRating,),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.width / 5,
                left: MediaQuery.of(context).size.width / 3 ,
                right: MediaQuery.of(context).size.width / 3 ,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFF3D69B),
                      width: 5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage('https://picsum.photos/200/300'),
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
