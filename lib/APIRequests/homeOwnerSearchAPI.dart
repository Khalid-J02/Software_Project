import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerSearchAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Get suggestion names for service providers
  static Future<List<String>> getSuggestionNames() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/suggestionNames'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> suggestionNamesList = jsonDecode(response.body);
        final List<String> suggestionNames = suggestionNamesList
            .map((name) {
          if (name is Map<String, dynamic> && name.containsKey('Username')) {
            return name['Username'].toString();
          } else {
            return ''; // Handle the case where 'Username' is not present
          }
        })
            .toList();

        return suggestionNames;
      } else {
        throw http.ClientException(
          'Failed to get suggestion names\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/suggestionNames'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      throw e; // Rethrow the exception to let the caller handle it
    }
  }

  // Search for service providers by name
  static Future<List<Map<String, dynamic>>> searchServiceProvidersByName(String searchTerm) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/searchServiceProviders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({'searchTerm': searchTerm}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<Map<String, dynamic>> searchResults = List<Map<String, dynamic>>.from(responseData['results']);
        print(searchResults);
        return searchResults;
      } else {
        throw http.ClientException(
          'Failed to search service providers\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/searchServiceProviders'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow;
    }
  }

  // Get service providers for a specific service type
  static Future<List<Map<String, dynamic>>> getServiceProvidersByServiceType(String serviceType) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/serviceProviders/$serviceType'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> serviceProvidersList = jsonDecode(response.body);
        final List<Map<String, dynamic>> serviceProviders = List<Map<String, dynamic>>.from(serviceProvidersList);
        print(serviceProviders);
        return serviceProviders;
      } else {
        throw http.ClientException(
          'Failed to get service providers by service type\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/serviceProviders/$serviceType'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  // Get the best 4 service providers for each service type
  static Future<List<Map<String, dynamic>>> getBestFourServiceProviders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/bestFourServiceProviders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> providersList = jsonDecode(response.body);
        final List<Map<String, dynamic>> providers = List<Map<String, dynamic>>.from(providersList);
        print('In the API: $providers');
        return providers;
      } else {
        throw http.ClientException(
          'Failed to fetch best service providers\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/getBestServiceProviders'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }


  // Filter and search for service providers based on rating, price, city
  static Future<List<Map<String, dynamic>>> filterServiceProviders({
    double? rating,
    double? minPrice,
    double? maxPrice,
    String? city,
    String? serviceType,

  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/filterServiceProviders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'rating': rating,
          'minPrice': minPrice,
          'maxPrice': maxPrice,
          'city': city,
          'serviceType': serviceType,
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> filteredServiceProvidersList = jsonDecode(response.body);
        final List<Map<String, dynamic>> filteredServiceProviders = List<Map<String, dynamic>>.from(filteredServiceProvidersList);
        print(filteredServiceProviders);
        return filteredServiceProviders;
      } else {
        throw http.ClientException(
          'Failed to filter service providers\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/filterServiceProviders'),
        );
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }
}
