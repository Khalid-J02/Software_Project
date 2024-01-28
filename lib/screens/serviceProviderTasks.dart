import 'package:flutter/material.dart';
import '../APIRequests/messageSystem.dart';
import '../APIRequests/notificationsSystem.dart';
import '../APIRequests/serviceProviderTasksAPI.dart';
import '../Widgets/customAlertDialog.dart';
import '../Widgets/sp_TaskDetails.dart';
import 'package:get/get.dart';
import '../classes/language_constants.dart';

class ServiceProviderTasks extends StatefulWidget {
  const ServiceProviderTasks({super.key});

  @override
  State<ServiceProviderTasks> createState() => _ServiceProviderTasksState();
}

class _ServiceProviderTasksState extends State<ServiceProviderTasks> {
  List<Map<String, dynamic>> serviceProviderTasks = [];
  int notificationCount = 0;
  int unreadMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchUnreadMessageCount();
    _fetchNotifications();
    fetchServiceProviderProjects();
  }

  Future<void> _fetchUnreadMessageCount() async {
    try {
      Map<String, dynamic> responseData =
          await MessagingAPI.getHomeOwnersForServiceProvider();

      if (responseData.containsKey('unreadConversationsCount')) {
        unreadMessageCount = responseData['unreadConversationsCount'];
      } else {
        throw Exception('unreadConversationsCount key not found in response');
      }

      setState(() {
        // Update your state if necessary
      });
    } catch (e) {
      print('Error fetching unread message count: $e');
    }
  }

  Future<void> _fetchNotifications() async {
    try {
      int count = await NotificationAPI.getNotificationCount();
      setState(() {
        notificationCount = count;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchServiceProviderProjects() async {
    try {
      final List<Map<String, dynamic>> projects =
          await ServiceProviderProjectsAPI.getServiceProviderProjects();
      setState(() {
        serviceProviderTasks = projects;
      });
    } catch (e) {
      print('Error fetching service provider projects: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translation(context)!.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.home,
            color: Color(0xFFF3D69B),
          ),
          title: Text(
            translation(context)!.serviceProviderTasksHomeText,
            style: const TextStyle(color: Color(0xFFF3D69B)),
          ),
          actions: [
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  const Icon(Icons.message, color: Color(0xFFF3D69B), size: 24),
                  if (unreadMessageCount >
                      0) // Only show if count is greater than 0
                    Positioned(
                      right: -3.2,
                      top: -3.2,
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 13,
                          minHeight: 13,
                        ),
                        child: Text(
                          '$unreadMessageCount', // Show the count here
                          style: const TextStyle(
                            color: Color(0xFFF3D69B),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Get.offNamed('/Messages');
              },
            ),
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Icon(Icons.notifications, color: Color(0xFFF3D69B), size: 24),
                  if (notificationCount >
                      0) // Only show if count is greater than 0
                    Positioned(
                      right: -3.2,
                      top: -3.2,
                      child: Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 13,
                          minHeight: 13,
                        ),
                        child: Text(
                          '$notificationCount', // Show the count here
                          style: const TextStyle(
                            color: Color(0xFFF3D69B),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () {
                Get.offNamed('/Notifications');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color(0xFFF3D69B),
                size: 24,
              ), // Choose your preferred icon
              onPressed: () async {
                bool? shouldLogout =
                    await CustomAlertDialog.showLogoutConfirmationDialog(
                        context);
                if (shouldLogout == true) {
                  Get.offAllNamed('/');
                }
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Color(0xFF122247), //Colors.white,
        ),
        body: SafeArea(
          child: Container(
            color: Color(0xFF2F4771),
            child: ListView.builder(
              itemCount: serviceProviderTasks.length,
              itemBuilder: (context, index) {
                final task = serviceProviderTasks[index];
                return SPTasksDetails(
                  taskProjectName: task['projectName'] ?? 'Unknown',
                  taskProjectOwner: task['homeOwnerName'] ?? 'Unknown',
                  taskProjectId: task['projectID'].toString(),
                  taskStatus: task['taskStatus'] ?? 'Unknown',
                  taskID: task['taskId'].toString() ?? 'Unknown',
                  taskNumber: task['taskNumber'].toString() ?? 'Unknown',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
