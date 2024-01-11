import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeOwnerTasksAPI {
  // static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

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

  static Future<Map<String, dynamic>> getProjectInfoData(int projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getProjectInfoData/$projectId'),
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
          'Failed to load getProjectInfoData \nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/getProjectInfoData/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during getProjectInfoData API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> saveBuildingData(int projectId, int? numRooms, int? numFloors, double? buildingArea) async {
    try {
      final Map<String, dynamic> requestBody = {
        'numRooms': numRooms,
        'numFloors': numFloors,
        'buildingArea': buildingArea,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/saveBuildingData/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode(requestBody), // Include the request body here
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw http.ClientException(
          'Failed to load saveBuildingData \nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/saveBuildingData/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during saveBuildingData API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<Map<String, dynamic>> saveMaterialProvider(int projectId, String materialProvider) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/homeowner/saveMaterialProvider/$projectId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({'materialProvider': materialProvider}),

      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw http.ClientException(
          'Failed to load saveMaterialProvider \nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/saveMaterialProvider/$projectId'),
        );
      }
    } catch (e) {
      print('Exception during saveMaterialProvider API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  }

  static Future<List<Map<String, dynamic>>> getServiceProviderCatalogItems(int serviceProviderId ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/catalogItems/$serviceProviderId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> catalogItemsData = jsonDecode(response.body);
        return catalogItemsData.cast<Map<String, dynamic>>();
      } else {
        throw http.ClientException(
          'Failed to load catalog items\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/catalogItems/'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProviderCatalogItems API call: $e');
      throw e;
    }
  }

  static Future<Map<String, dynamic>> getServiceProviderCatalogItemDetails(int catalogId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/catalog/$catalogId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> itemDetails = jsonDecode(response.body);
        return itemDetails;
      } else {
        throw http.ClientException(
          'Failed to fetch item details\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/catalog/$catalogId'),
        );
      }
    } catch (e) {
      print('Exception during getServiceProviderCatalogItemDetails API call: $e');
      throw e;
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
          Uri.parse('$baseUrl/homeowner/propertySurvey/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getPropertySurvey API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //task1

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
          Uri.parse('$baseUrl/homeowner/permitsRegulatoryInfo/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getPermitsRegulatoryInfo API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //task2

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
          'Failed to load soil investigation information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/soilInvestigation/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during soilInvestigation API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //task3

  static Future<Map<String, dynamic>> getDesignAndPlanning(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/designAndPlanning/$taskId'), // Update with your actual endpoint
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> getDesignAndPlanningData = jsonDecode(response.body);
        return getDesignAndPlanningData;
      } else {
        throw http.ClientException(
          'Failed to load design and planning information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/designAndPlanning/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getDesignAndPlanning API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //task4

  static Future<Map<String, dynamic>> getApprovals(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getApprovals/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> getApprovalsData = jsonDecode(response.body);

        return getApprovalsData;
      } else {
        throw http.ClientException(
          'Failed to load getApprovals information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/getApprovals/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getApprovals API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //task5

  static Future<Map<String, dynamic>> getTask6(String taskId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/homeowner/getTask6/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> getTask6Data = jsonDecode(response.body);

        return getTask6Data;
      } else {
        throw http.ClientException(
          'Failed to load getTask6 information\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/homeowner/getTask6/$taskId'),
        );
      }
    } catch (e) {
      print('Exception during getTask6 API call: $e');
      rethrow; // Rethrow the exception to let the caller handle it
    }
  } //I used it from task6 to task 15

}
