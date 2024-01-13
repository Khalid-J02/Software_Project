import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RequestsAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  // Method to get all requests for a service provider
  static Future<List<Map<String, dynamic>>> getAllRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/requests'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> requestsData = jsonDecode(response.body);
        return requestsData.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load requests\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/requests'),
        );
      }
    } catch (e) {
      print('Exception during getAllRequests API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }

  // Method to accept a request
  static Future<dynamic> acceptRequest(String requestId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/requests/$requestId/accept'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        String message= jsonDecode(response.body);
        return {'message': message};
      } else {
        throw http.ClientException(
          'Failed to accept request\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/requests/$requestId/accept'),
        );
      }
    } catch (e) {
      print('Exception during acceptRequest API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }

  // Method to decline a request
  static Future<dynamic> declineRequest(String requestId, String declineReason) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/requests/$requestId/decline'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({'declineReason': declineReason}),
      );

      if (response.statusCode == 200) {
        String message= jsonDecode(response.body);
        return {'message': message};

      } else {
        throw http.ClientException(
          'Failed to decline request\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/requests/$requestId/decline'),
        );
      }
    } catch (e) {
      print('Exception during declineRequest API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getProjectDetails(String projectId, String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/projectDetails/$projectId/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> projectData = jsonDecode(response.body);
        return projectData;
      } else {
        throw http.ClientException(
          'Failed to load project Details\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/projectDetails/$projectId/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getProjectDetails API call: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getProfilefromID(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profilefromID/$userId'),
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
}
