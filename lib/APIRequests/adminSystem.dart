import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class AdminAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<List<dynamic>> getProjectCountByCity() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/getProjectCountByCity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve project count by city');
    }
  }

  static Future<List<dynamic>> getProjectCountByCompletion() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/getProjectCountByCompletion'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve project count by completion');
    }
  }

  static Future<dynamic> getProjectCountByStatusForCity(String city) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/getProjectCountByStatusForCity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode({'input': city}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve project count by status for city');
    }
  }

  static Future<List<dynamic>> getHomeownerCountByCity() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/getHomeownerCountByCity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve homeowner count by city');
    }
  }

  static Future<List<dynamic>> getServiceProviderCountByCity() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/getServiceProviderCountByCity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve service provider count by city');
    }
  }

  static Future<dynamic> getServiceProviderCountByRating(String input) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/getServiceProviderCountByRating'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode({'input': input}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve service provider count by rating');
    }
  }

  static Future<List<dynamic>> getTaskCountByServiceType() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/getTaskCountByServiceType'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve task count by service type');
    }
  }

  static Future<dynamic> getTaskCountByStatusForCity(String input) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/getTaskCountByStatusForCity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode({'input': input}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve task count by status for city');
    }
  }

  static Future<dynamic> addMatirealProvider(
    String name,
    String userType,
    String profilePicture,
    String city,
    String serviceType,
    String bio,
    String phoneNumber,
      ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/admin/addMatirealProvider'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode({
        'name': name,
        'userType': userType,
        'profilepicture': profilePicture,
        'city': city,
        'serviceType': serviceType,
        'bio': bio,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add a material provider');
    }
  }
}