import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServiceProviderProjectsAPI {
  // static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  // Method to get the service provider's projects
  static Future<List<Map<String, dynamic>>> getServiceProviderProjects() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/projects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> projectsData = jsonDecode(response.body);
        try {
          // Extract project details from the response
          final List<Map<String, dynamic>> projects = projectsData
              .map((project) => {
            'taskId': project['TaskID'],
            'taskStatus': project['TaskStatus'],
            'taskNumber': project['TaskNumber'],
            'projectName': project['ProjectName'],
            'projectID':  project['ProjectID'],
            'homeOwnerName': project['HomeOwnerName'],
          })
              .toList();
          return projects;
        } catch (e) {
          print('Error decoding service provider projects: $e');
          throw Exception('Error decoding service provider projects');
        }
      } else {
        throw http.ClientException(
          'Failed to load service provider projects\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/projects'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }
}
