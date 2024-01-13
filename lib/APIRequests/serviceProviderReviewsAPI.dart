import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReviewsAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  // Method to get all reviews for a service provider
  static Future<List<Map<String, dynamic>>> getAllReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/reviews'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> reviewsData = jsonDecode(response.body);
        return reviewsData.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load reviews\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/reviews'),
        );
      }
    } catch (e) {
      print('Exception during getAllReviews For Service Provider it self API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }
}
