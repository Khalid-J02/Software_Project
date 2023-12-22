import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WorkExperienceAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Method to get work experiences for a service provider
  static Future<List<Map<String, dynamic>>> getWorkExperiences() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/workExperiences'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> workExperiencesData = jsonDecode(response.body);
        return workExperiencesData.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load work experiences\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/workExperiences'),
        );
      }
    } catch (e) {
      print('Exception during getWorkExperiences API call: $e');
      throw e;
    }
  }

  // Method to add a work experience
  static Future<String> addWorkExperience(
      String workImage, String workName, String workDescription) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/addworkExperience'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'workImage': workImage,
          'workName': workName,
          'workDescription': workDescription,
        }),
      );

      if (response.statusCode == 200) {
        String workExperienceId = jsonDecode(response.body);
        return workExperienceId;
      } else {
        throw http.ClientException(
          'Failed to add work experience\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/addworkExperience'),
        );
      }
    } catch (e) {
      print('Exception during addWorkExperience API call: $e');
      throw e;
    }
  }

  // Method to get work experience details by WorkID
  static Future<Map<String, dynamic>> getWorkExpDetails(String workExpId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/workExperiences/$workExpId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> workExpDetails = jsonDecode(response.body);
        return workExpDetails;
      } else {
        throw http.ClientException(
          'Failed to fetch work experience details\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/workExperiences/$workExpId'),
        );
      }
    } catch (e) {
      print('Exception during getWorkExpDetails API call: $e');
      throw e;
    }
  }

  // Method to edit work experience details by WorkID
  static Future<String> editWorkExpDetails(
      String workExpId, String workImage, String workName, String workDescription) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/serviceprovider/workExperiences/$workExpId/edit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'workImage': workImage,
          'workName': workName,
          'workDescription': workDescription,
        }),
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        throw http.ClientException(
          'Failed to edit work experience\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/workExperiences/$workExpId/edit'),
        );
      }
    } catch (e) {
      print('Exception during editWorkExpDetails API call: $e');
      throw e;
    }
  }
}
