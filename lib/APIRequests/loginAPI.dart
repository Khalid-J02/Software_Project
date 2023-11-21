import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginAPI{

  static const String baseUrl = 'http://10.0.2.2:3000';
  Future<dynamic> logIn(String email, String password) async {

    final response = await http.post(Uri.parse('$baseUrl/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));


    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }
}