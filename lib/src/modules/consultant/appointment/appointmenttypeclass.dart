import 'dart:convert';

import 'package:consultant_product/src/modules/consultant/appointment/appointmenttypeModel.dart';
import 'package:flutter/material.dart';

import '../../../api_services/urls.dart';

import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<AppointmenttypeModel?> appointmenttypeclass() async {
    var url = getappointmenttype;
    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final jsonStudent = jsonDecode(response.body);
      return AppointmenttypeModel.fromJson(jsonStudent);
    } else if (response.statusCode == 404) {
      return AppointmenttypeModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      return AppointmenttypeModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return AppointmenttypeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
