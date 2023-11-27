import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerProfilePageAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );
    if (response.statusCode == 200) {
      print('In the get profileee');
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  static Future<void> editProfile( Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/user/editProfile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode(profileData),
    );

    if (response.statusCode == 200) {
      // Profile updated successfully
      print('Profile updated successfully');
    } else {
      throw Exception('Failed to update profile');
    }
  }
}
