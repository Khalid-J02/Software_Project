import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class userRegAPI {

  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

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
    }else if (response.statusCode ==400){

      String errorMessage= jsonDecode(response.body);
      return {'error': errorMessage};

    }else {
      throw Exception('Failed to sign in');
    }
  }

  Future<dynamic> register(String firstname, String lastname, String userType,
      String email, String password, String confirmPassword,
      String profilepicture, String phonenumber, String city,
      String serviceType, String bio) async {
    final response = await http.post(Uri.parse('$baseUrl/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstname': firstname,
        'lastname': lastname,
        'userType': userType,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'profilepicture': profilepicture,
        'phonenumber': phonenumber,
        'city': city,
        'serviceType': serviceType,
        'bio': bio,
      }),
    );


    if (response.statusCode == 200) {

      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Update environment variables
      dotenv.env['userID'] = responseData['userID'].toString();
      dotenv.env['userType'] = responseData['userType'];

      // Store the authentication token
      dotenv.env['token'] = responseData['token'];

      return responseData;

    }else if (response.statusCode ==400){

          String errorMessage= jsonDecode(response.body);
          return {'error': errorMessage};

      }else {
        // If there is no specific error message, return a generic error
      throw Exception('Failed to register');
      }

    }

  Future<dynamic> forgotPassword(String email) async {

      final response = await http.post(
        Uri.parse('$baseUrl/user/forgotPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String userId = responseData['userId'].toString(); // Extract user ID
        String message = responseData['message'];

        // Update environment variables
        dotenv.env['userID'] = userId;

        // Return the entire response for further processing if needed
        return {'message': message, 'userId': userId};

      } else if (response.statusCode == 400) {
        String errorMessage = jsonDecode(response.body);
        return {'error': errorMessage};


      } else {
        throw Exception('Password reset request failed');
      }

  }

  Future<dynamic> verifyCode(String userId, String providedCode) async {
      final response = await http.post(
        Uri.parse('$baseUrl/user/verifyCode/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'providedCode': providedCode}),
      );

      if (response.statusCode == 200) {
        return {'message': 'Verification Successful'};

      } else if (response.statusCode == 400) {
        String errorMessage = jsonDecode(response.body);
        return {'error': errorMessage};

      } else {
        throw Exception('Invalid Verification Code');
      }
    }

  Future<dynamic> resetPassword(String userId, String newPassword, String confirmPassword) async {

      final response = await http.post(
        Uri.parse('$baseUrl/user/resetPassword/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        return {'message': 'Password Reset Successful'};

      } else if (response.statusCode == 400) {
        String errorMessage = jsonDecode(response.body);
        return {'error': errorMessage};

      } else {
        throw Exception('Password Reset Failed');
      }

  }
}