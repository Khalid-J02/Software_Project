import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServiceProviderDataAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<Map<String, dynamic>> getServiceProData(String serviceProviderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/serviceProData/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> serviceProData = jsonDecode(response.body);
        return serviceProData;
      } else {
        throw http.ClientException(
          'Failed to load service provider data\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/serviceProData/$serviceProviderId'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProData API call: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getServiceProCatalogItems(String serviceProviderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/serviceProCatalogItems/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> catalogItems = jsonDecode(response.body);
        return catalogItems.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load catalog items\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/serviceProCatalogItems/$serviceProviderId'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProCatalogItems API call: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getServiceProWorkExperiences(String serviceProviderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/serviceProWorkExperiences/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> workExperiences = jsonDecode(response.body);
        return workExperiences.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load work experiences\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/serviceProWorkExperiences/$serviceProviderId'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProWorkExperiences API call: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getServiceProReviews(String serviceProviderId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/serviceProReviews/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> reviews = jsonDecode(response.body);
        return reviews.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load service provider reviews\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/serviceProReviews/$serviceProviderId'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProReviews API call: $e');
      rethrow;
    }
  }

  static Future<String> sendRequestForServiceProvider(String serviceProviderID, String taskID, String reqTaskDate) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/request/${serviceProviderID}/${taskID}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'reqTaskDate': reqTaskDate,
        }),
      );

      if (response.statusCode == 200) {
        final String requestStatus = jsonDecode(response.body);
        return requestStatus ;

      } else if (response.statusCode == 404) {
        final String requestStatus = jsonDecode(response.body);
        return requestStatus ;
      }
      else{
        throw http.ClientException(
          'Failed to send request for provider providers\nStatus code: ${response.statusCode}',
          // Uri.parse('$baseUrl/homeowner/filterServiceProviders'),
        );
      }
    } catch (e) {
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
}
