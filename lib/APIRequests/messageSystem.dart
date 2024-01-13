import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MessagingAPI {
  static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  // static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  // Function to send a message
  static Future<dynamic> sendMessage(String receiverId, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/sendMessage/$receiverId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
      body: json.encode({'content': content}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send message');
    }
  }

  // Function to get the inbox
  static Future<List<dynamic>> getInbox() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getInbox'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve inbox');
    }
  }

  // Function to get a conversation
  static Future<List<dynamic>> getConversation(String receiverId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getConversation/$receiverId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve conversation');
    }
  }

  // Function to get service providers for a homeowner
  static Future<List<dynamic>> getServiceProvidersForHomeowner() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getServiceProviders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve service providers');
    }
  }

  // Function to get homeowners for a service provider
  static Future<List<dynamic>> getHomeOwnersForServiceProvider() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getHomeOwners'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve homeowners');
    }
  }

}

