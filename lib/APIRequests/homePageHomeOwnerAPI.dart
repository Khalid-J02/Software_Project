import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerHomePageAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Method to get the homeowner's projects
  static Future<List<Map<String, dynamic>>> getHomeOwnerProjects() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/projects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> projectsData = jsonDecode(response.body);
        try {
          // Extract project names and IDs from the response
          final List<Map<String, dynamic>> projects = projectsData
              .map((project) => {
            'projectId': project['projectId'],
            'projectName': project['projectName'],
          })
              .toList();
          return projects;
        } catch (e) {
          print('Error decoding projects: $e');
          throw Exception('Error decoding projects');
        }
      } else {
        throw http.ClientException(
          'Failed to load homeowner projects\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/projects'),
        );
      }
    } catch (e) {
      print('Exception during getHomeOwnerProjects API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }

  // Method to add a new project
  static Future<String?> addNewProject({
    required String projectName,
    required String projectCity,
    required String projectLocation,
    required String projectEntryPoint,
    required String basinNumber,
    required String plotNumber,
  }) async {

    try {

      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/addProject'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'projectName': projectName,
          'projectCity': projectCity,
          'projectLocation': projectLocation,
          'projectEntryPoint': projectEntryPoint,
          'basinNumber':basinNumber,
          'plotNumber':plotNumber,
        }),
      );

      if (response.statusCode == 200) {
        // Project added successfully
        return response.body;

      } else {
        throw http.ClientException(
          'Failed to add a project\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/addProject'),
        );
      }
    } catch (e) {
      // Handle other exceptions, e.g., network issues
      print('Exception addNewProject during API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
}
