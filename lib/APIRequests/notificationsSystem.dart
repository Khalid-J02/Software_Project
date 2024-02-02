import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationAPI {
  // static const String baseUrl = 'http://10.0.2.2:3000';     // we activate this when using mobile
  static const String baseUrl = 'http://localhost:3000';     // we activate this when using web

  static Future<List<dynamic>> getNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getNotifications'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve notifications');
    }
  }

  // Function to get the count of unread notifications
  static Future<int> getNotificationCount() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/getNotificationCount'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to retrieve notification count');
    }
  }

  // Function to mark all notifications as read
  static Future<bool> markAllNotificationsAsRead() async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/markAllNotificationsAsRead'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['token']}',
      },
    );

    return response.statusCode == 200;
  }
}
