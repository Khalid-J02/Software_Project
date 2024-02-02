import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerReviewAPI {
  // static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  static Future<Map<String, dynamic>> addOrUpdateReview(String taskId, String reviewContent, int rating,) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/addOrUpdateReview/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'reviewContent': reviewContent,
          'rating': rating,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> reviewData = jsonDecode(response.body);
        return reviewData;

      } else {
        throw http.ClientException(
          'Failed to add/update review\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/reviews/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during addOrUpdateReview API call: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getReviewDetails(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getReviewDetails/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> reviewData = jsonDecode(response.body);
        return reviewData;
      } else {
        throw http.ClientException(
          'Failed to get review details\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/getReviewDetails/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getReviewDetails API call: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getReviewsInfo(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getReviewsInfo/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> reviewData = jsonDecode(response.body);
        return reviewData;
      } else {
        throw http.ClientException(
          'Failed to get review details\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/getReviewsInfo/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getReviewsInfo API call: $e');
      rethrow;
    }
  }
}
