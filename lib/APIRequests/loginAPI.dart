import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginAPI{

  static const String baseUrl = 'http://10.0.2.2:3000';
  Future<dynamic> logIn(String email, String password) async {

    final response = await http.post(Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Update environment variables
      dotenv.env['userID'] = responseData['userID'].toString();
      dotenv.env['userType'] = responseData['userType'];

      // Store the authentication token
      dotenv.env['token'] = responseData['token'];

      // Return the entire response for further processing if needed
      return responseData;
    } else {
      throw Exception('Failed to sign in');
    }
  }
}