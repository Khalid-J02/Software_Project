import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerTasksAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<String> getSurveyDocument(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getSurveyDocument/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final String surveyDocument = jsonDecode(response.body);
        return surveyDocument;
      } else {
        throw http.ClientException(
          'Failed to load survey document\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/getSurveyDocumentfromProjectInfo/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getSurveyDocument API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<String> getPermitsDocument(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getPermitsDocument/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final String permitsDocument = jsonDecode(response.body);
        return permitsDocument;
      } else {
        throw http.ClientException(
          'Failed to load permits document\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/getPermitsDocumentfromProjectInfo/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getPermitsDocument API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<String> getSoilDocument(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getSoilDocument/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final String soilDocument = jsonDecode(response.body);
        return soilDocument;
      } else {
        throw http.ClientException(
          'Failed to load soil document\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/getSoilDocumentfromProjectInfo/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getSoilDocument API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
//-------------------------------------------------------------------------------------------//
  static Future<String> checkPreviousTaskStatus(int projectId, int taskNumber ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/previousTaskStatus/$projectId/$taskNumber'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;

      } else {
        throw http.ClientException(
          'Failed to load checkPreviousTaskStatus\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/previousTaskStatus/$projectId/$taskNumber'),
        );
      }
    } catch (e) {
      print('Exception during checkPreviousTaskStatus API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
//-------------------------------------------------------------------------------------------//

  static Future<Map<String, dynamic>> getPropertySurvey(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/propertySurvey/$taskId'), // Update with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> propertySurveyData = jsonDecode(response.body);
        return propertySurveyData;
      } else {
        throw http.ClientException(
          'Failed to load property survey information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/propertySurvey/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getPropertySurvey API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getPermitsRegulatoryInfo(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/permitsRegulatoryInfo/$taskId'), // Update with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> permitsRegulatoryInfoData = jsonDecode(response.body);

        return permitsRegulatoryInfoData;
      } else {
        throw http.ClientException(
          'Failed to load permits and regulatory information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/permitsRegulatoryInfo/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getPermitsRegulatoryInfo API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getSoilInvestigation(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/soilInvestigation/$taskId'), // Update with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> soilInvestigationData = jsonDecode(response.body);

        return soilInvestigationData;
      } else {
        throw http.ClientException(
          'Failed to load permits and regulatory information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/permitsRegulatoryInfo/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getPermitsRegulatoryInfo API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

}
