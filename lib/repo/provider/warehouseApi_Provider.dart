import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/firebaseUid_models.dart';
import 'package:warehouse_application/models/registerUser_model.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/models/userRole_model.dart';

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? warehouse})
      : _warehouse = warehouse ?? http.Client();

  final http.Client _warehouse;
  final String _baseUrl1 =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0';

  final String _baseUrl2 =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_2_0';

  Future regisUser(RegisUser regis) async {
    final Uri _url = Uri.parse('$_baseUrl1/user/Create_user');
    try {
      final http.Response response = await _warehouse.post(
        _url,
        headers: <String, String>{
          'Content-type': 'application/json',
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
    final Uri _url = Uri.parse('$_baseUrl1/user/F_user/$firebaseUid');
    try {
      final http.Response response = await _warehouse.get(_url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMessage = jsonDecode(response.body);
        if (responseMessage['message'] == 'Success') {
          return ReadUserFirebaseUID.fromJson(responseMessage);
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

  Future<UserPack> getRole(int roleId) async {
    final Uri _url = Uri.parse('$_baseUrl1/user/User_role');

    try {
      final http.Response response = await _warehouse.get(_url);
      if (response.statusCode == 200) {
        return UserPack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future createProduct(CreateProduct createProduct) async {
    final Uri _url = Uri.parse('$_baseUrl2/product/Product');
    try {
      final http.Response response = await _warehouse.post(
        _url,
        headers: <String, String>{
          'Content-type': 'application/json',
          'Firebase_UID': '*firebase_uid*'
        },
        body: jsonEncode(createProduct),
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
}
