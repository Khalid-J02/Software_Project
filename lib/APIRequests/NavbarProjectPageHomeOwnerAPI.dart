import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerProjectPageNavbarAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<Map<String, dynamic>> getProjectInformation(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/projectInfo/$projectId'),
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
          'Failed to load project information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/projectInfo/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getProjectInformation API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<List<Map<String, dynamic>>> getProjectTasks(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/projectTasks/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> tasksList = jsonDecode(response.body);
        final List<Map<String, dynamic>> tasks = List<Map<String, dynamic>>.from(tasksList);
        return tasks;
      } else {
        throw http.ClientException(
          'Failed to load project tasks\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/projectTasks/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getProjectTasks API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
}
