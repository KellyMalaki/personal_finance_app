import 'dart:convert';

import 'package:flutter/services.dart';

//Function to read dashboard data
Future<Map<dynamic, dynamic>> readMonthData(String path)  async {
  final String response = await rootBundle.loadString(path);
  return await json.decode(response);
}