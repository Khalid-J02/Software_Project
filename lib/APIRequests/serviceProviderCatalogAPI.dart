import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CatalogAPI {
  // static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  // Method to get catalog items for a service provider
  static Future<List<Map<String, dynamic>>> getCatalogItems() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/catalog/items'),
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
          Uri.parse('$baseUrl/serviceprovider/catalog/items'),
        );
      }
    } catch (e) {
      print('Exception during getCatalogItems API call: $e');
      throw e;
    }
  }

  // Method to add an item to the catalog
  static Future<int> addItemToCatalog(String itemName, String itemImage, double itemPrice, String itemDescription, List<String> itemColors) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/serviceprovider/catalog/addItem'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'itemName': itemName,
          'itemImage': itemImage,
          'itemPrice': itemPrice,
          'itemDescription': itemDescription,
          'itemColors': itemColors,
        }),
      );
      if (response.statusCode == 200) {
        int catalogItemId = jsonDecode(response.body);
        return catalogItemId;
      } else {
        throw http.ClientException(
          'Failed to add item to catalog\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/catalog/addItem'),
        );
      }
    } catch (e) {
      print('Exception during addItemToCatalog API call: $e');
      throw e;
    }
  }

  // Method to get item details by CatalogID
  static Future<Map<String, dynamic>> getItemDetails(String catalogId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId'),
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
          Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId'),
        );
      }
    } catch (e) {
      print('Exception during getItemDetails API call: $e');
      throw e;
    }
  }

  // Method to edit item details by CatalogID
  static Future<String> editItemDetails(String catalogId, String itemName, double itemPrice, String itemDescription, List<String> itemColors) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId/editItem'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'itemName': itemName,
          'itemPrice': itemPrice,
          'itemDescription': itemDescription,
          'itemColors': itemColors,
        }),
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        throw http.ClientException(
          'Failed to edit item in catalog\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId/editItem'),
        );
      }
    } catch (e) {
      print('Exception during editItemDetails API call: $e');
      throw e;
    }
  }

  static Future<String> editItemImage(String catalogId, String itemImage) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId/editItemImage'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '${dotenv.env['token']}',
        },
        body: jsonEncode({
          'itemImage': itemImage,
        }),
      );

      if (response.statusCode == 200) {
        String message = jsonDecode(response.body);
        return message;
      } else {
        throw http.ClientException(
          'Failed to edit item image in catalog\nStatus code: ${response.statusCode}',
          Uri.parse('$baseUrl/serviceprovider/catalog/$catalogId/editItemImage'),
        );
      }
    } catch (e) {
      print('Exception during editItemImage API call: $e');
      throw e;
    }
  }
}
