import 'package:buildnex/screens/MSG_System/Widgets/userItem.dart';
import 'package:buildnex/screens/MSG_System/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../APIRequests/messageSystem.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListChatScreen> {

  List<UserModel> chatData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  Future<void> _loadChatData() async {
    try {
      var data ;
      if(dotenv.env['userType'] == 'HomeOwner'){
        data = await MessagingAPI.getServiceProvidersForHomeowner();
      }else{
        data = await MessagingAPI.getHomeOwnersForServiceProvider();
      }

      setState(() {
        chatData = data.map<UserModel>((item) => UserModel.fromJson(item)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFFF3D69B),
            fontSize: 22
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF122247),//Colors.white,
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: chatData.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return UserItemProfile(user: chatData[index]);
          },
        ),
      ),
    );
  }
}