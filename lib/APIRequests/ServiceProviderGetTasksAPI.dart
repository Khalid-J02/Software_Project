import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServiceProviderGetTasksAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  static Future<Map<String, dynamic>> getTask1Data(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask1/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task1Data = jsonDecode(response.body);
        return task1Data;
      } else {
        throw http.ClientException(
          'Failed to load task1 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask1/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getTask1Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask1

  static Future<String> setTask1Data( String taskId, String projectId, String propertySize, String surveyDocument, String serProNotes, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask1/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'propertySize': propertySize,
          'surveyDocument': surveyDocument,
          'serProNotes': serProNotes,
          'status' : status,
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task1 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask1/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during setTask1Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getTask2Data(String taskId, String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask2/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task2Data = jsonDecode(response.body);
        return task2Data;
      } else {
        throw http.ClientException(
          'Failed to load task2 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask2/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getTask2Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask2

  static Future<String> setTask2Data( String taskId, String projectId, String permitsDocument, String serProNotes, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask2/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'permitsDocument': permitsDocument,
          'serProNotes': serProNotes,
          'status' : status
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task2 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask2/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during setTask2Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getTask3Data(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask3/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task3Data = jsonDecode(response.body);
        return task3Data;
      } else {
        throw http.ClientException(
          'Failed to load task3 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask3/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getTask3Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask1

  static Future<String> setTask3Data( String taskId, String projectId, String soilDocument, String serProNotes, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask3/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'soilDocument': soilDocument,
          'serProNotes': serProNotes,
          'status' : status
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task3 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask3/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during setTask3Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getTask4Data(String taskId, String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask4/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task4Data = jsonDecode(response.body);
        return task4Data;
      } else {
        throw http.ClientException(
          'Failed to load task4 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask4/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getTask4Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask4

  static Future<String> setTask4Data( String taskId, String projectId, String designDocument, String foundationDocument, String plumbingDocument, String electricalDocument,String insulationAndHVACDocument,  String serProNotes, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask4/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'designDocument': designDocument,
          'foundationDocument': foundationDocument,
          'plumbingDocument': plumbingDocument,
          'electricalDocument': electricalDocument,
          'insulationAndHVACDocument': insulationAndHVACDocument,
          'serProNotes': serProNotes,
          'status' : status
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task4 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask4/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during setTask4Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getTask5Data(String taskId, String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask5/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task5Data = jsonDecode(response.body);
        return task5Data;
      } else {
        throw http.ClientException(
          'Failed to load task5 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask5/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getTask5Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask5

  static Future<String> setTask5Data( String taskId, String projectId, String approvalsDocument, String serProNotes, String status) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask5/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'approvalsDocument': approvalsDocument,
          'serProNotes': serProNotes,
          'status' : status
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task5 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask5/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during setTask5Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> getTask6Data(String taskId, String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/getTask6/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> task6Data = jsonDecode(response.body);
        return task6Data;
      } else {
        throw http.ClientException(
          'Failed to load task5 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/getTask6/$taskId/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getTask6Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //getTask4

  static Future<String> setTask6Data( String taskId, String serProNotes, String status, String projectId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/setTask6/$taskId/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'serProNotes': serProNotes,
          'status' : status
        }),
      );

      if (response.statusCode == 200) {
        return 'Data updated successfully';
      } else {
        throw http.ClientException(
          'Failed to update task6 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/setTask6/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during setTask6Data API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

}
