import 'package:flutter/material.dart';

import '../Widgets/sp_RequestsDetails.dart';
import '../APIRequests/serviceProviderRequestsAPI.dart';

class ServiceProviderRequests extends StatefulWidget {
  const ServiceProviderRequests({super.key});

  @override
  State<ServiceProviderRequests> createState() => _ServiceProviderRequestsState();
}

class _ServiceProviderRequestsState extends State<ServiceProviderRequests> {

  List<Map<String, dynamic>> serviceProviderRequests = [];

  void _removeproject(String projectName) {
    setState(() {
      serviceProviderRequests.removeWhere((request) =>
      request['projectName'] == projectName);
    });
  }
  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      final requests = await RequestsAPI.getAllRequests();
      setState(() {
        serviceProviderRequests = requests;
      });
    } catch (e) {
      // Handle the error
      print('Error loading requests: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFF2F4771),
          child: ListView.builder(
            itemCount: serviceProviderRequests.length,
            itemBuilder: (context, index) {
              final request = serviceProviderRequests[index];
              return SPRequestDetails(
                taskProjectName: request['projectName'],
                taskHomeOwnerName: request['homeOwnerName'],
                taskProjectId: request['projectId'].toString(),
                taskHomeOwnerId: request['homeOwnerId'].toString(),
                requestId: request['requestId'].toString(),
                removeProject: _removeproject,
              );
            },
          ),
        ),
      ),
    );
  }
}