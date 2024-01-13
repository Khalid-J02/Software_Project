import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Widgets/customAlertDialog.dart';

class HomeOwnerProfilePageAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  static Future<dynamic> editProfile( Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/editProfile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode(profileData),
    );

    if (response.statusCode == 200) {
      String message= jsonDecode(response.body);
      return {'message': message};

    }else if (response.statusCode == 400) {
      String errorMessage= jsonDecode(response.body);
      return {'error': errorMessage};
    }
    else{
      throw Exception('Failed to update profile');
    }
  }

  static Future<String> editUserProfileImage(String userImage) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/editProfileImage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'userImage': userImage,
        }),
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        throw http.ClientException(
          'Failed to edit user profile image\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/editProfileImage'),
        );
      }
    } catch (e) {
      print('Exception during editUserProfileImage API call: $e');
      throw e;
    }
  }
}
