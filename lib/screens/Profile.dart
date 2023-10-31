import 'package:buildnex/Widgets/profileData.dart';
import 'package:buildnex/Widgets/userProfileDataDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MaterialApp(home: const ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String userName = 'Khalid Ahmad Jabr';
  String userRole = 'Home Owner' ;

  String userEmail = 'khalid.asej6@gmail.com';
  String userBio = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id risus ac turpis vehicula lacinia. Proin auctor varius mi, ac auctor leo laoreet ac. Vestibulum quis felis nec odio rhoncus ullamcorper. Quisque tincidunt bibendum sapien, at scelerisque massa lacinia vel. Sed ac eros nec justo fermentum tincidunt. Suspendisse potenti. ' ;
  String userPhoneNum = '+972 59-258-5190';

  Future <List<String>?> editProfile()=> showDialog <List<String>>(
      context: context,
      builder: (BuildContext context){
        return UserProfileDataDialog(phoneNumber: userPhoneNum, eMail: userEmail, bio: userBio,);
      }
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFF122247),
                    padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
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
                    child: ProfileData(userName: userName, userEmail: userEmail , userRole: userRole, userBio: userBio, userPhone: userPhoneNum,),
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
    );
  }
}
