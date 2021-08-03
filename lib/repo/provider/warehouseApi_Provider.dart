import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warehouse_application/models/registerUser_model.dart';
import 'package:warehouse_application/models/response_model.dart';

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? warehouse}) : _warehouse = warehouse ?? http.Client();
  
  final http.Client _warehouse;
  final String _baseUrl = 'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0';

  Future regisUser(RegisUser regis) async {
    final Uri _url = Uri.parse('$_baseUrl/user/Create_user');
    try {
      final http.Response response = await _warehouse.post(
        _url, 
        headers: <String, String>{
          'Content-type' : 'application/json',
        },
        body: jsonEncode(regis),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMessage = jsonDecode(response.body);
        if (responseMessage['message'] == 'Success') {
          return ResponseBerhasil.fromJson(responseMessage);
        } else {
          return ResponseGagal.fromJson(responseMessage);
        }
      } 
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }

  Future loginUser(String firebaseUid) async {
    final Uri _url = Uri.parse('$_baseUrl/user/F_user/:$firebaseUid');     
    try {
      final http.Response response = await _warehouse.get(_url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMessage = jsonDecode(response.body);
        if (responseMessage['message'] == 'Success') {
          return ResponseBerhasil.fromJson(responseMessage);
        } else {
          return ResponseGagal.fromJson(responseMessage);
        }
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }
  
  // Future loginUser(String login) async {
  //   final Uri _url = Uri.parse('$_baseUrl//user/F_user/:Firebase_UID');
  //   try {
  //     final http.Response response = await _warehouse.get(_url);
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseMessage = jsonDecode(response.body);
  //       if (responseMessage['message'] == 'Success') {
  //         return ResponseBerhasil.fromJson(responseMessage);
  //       } else {
  //         return ResponseGagal.fromJson(responseMessage);
  //       }
  //     }
  //     throw Exception(response.statusCode);
  //   } catch (e) {
  //     print('$e');
  //     throw Exception(e);
  //   }
  // }
  
}