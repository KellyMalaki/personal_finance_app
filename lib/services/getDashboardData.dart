import 'dart:convert';

import 'package:flutter/services.dart';

//Function to read dashboard data
Future<Map<dynamic, dynamic>> readDashboardData()  async {
  final String response = await rootBundle.loadString('assets/data_from_backend/dashboard_data.json');
  //Map<String, dynamic> result = await json.decode(response);
  return await json.decode(response);
}