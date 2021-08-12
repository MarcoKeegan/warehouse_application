import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/firebaseUid_models.dart';
import 'package:warehouse_application/models/productType_models.dart';
import 'package:warehouse_application/models/readProduct_models.dart';
import 'package:warehouse_application/models/registerUser_model.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/models/userRole_model.dart';

class WarehouseApiProvider {
  WarehouseApiProvider({http.Client? warehouse})
      : _warehouse = warehouse ?? http.Client();

  final http.Client _warehouse;
  final String _baseUrl =
      'https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_2_0';

  Future regisUser(RegisUser regis) async {
    final Uri _url = Uri.parse('$_baseUrl/user/Create_user');
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
    final Uri _url = Uri.parse('$_baseUrl/user/F_user/$firebaseUid');
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
    final Uri _url = Uri.parse('$_baseUrl/user/User_role');

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

  Future createProduct(CreateProduct createProduct, String firebaseUid) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product');
    try {
      final http.Response response = await _warehouse.post(
        _url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Firebase_UID": firebaseUid,
        },
        body: jsonEncode(createProduct),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseMessage = jsonDecode(response.body);
        if (responseMessage['message'] == 'Success') {
          return ResponseBerhasil.fromJson(responseMessage);
        } else {
          print(response.body);
          return ResponseGagal.fromJson(responseMessage);
        }
      }
      throw Exception(response.statusCode);
    } catch (e) {
      print('$e');
      throw Exception(e);
    }
  }

  Future<ProductTypePack> getProductType(int productId) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product_type');
    try {
      final http.Response response = await _warehouse.get(_url);
      if (response.statusCode == 200) {
        return ProductTypePack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getAllProduct(int readAllProduct) async {
    final Uri _url = Uri.parse('$_baseUrl/product/Product_all');

    try {
      final http.Response response = await _warehouse.get(_url);
      if (response.statusCode == 200) {
        return ReadAllProduct.fromJson(jsonDecode(response.body));
      } else {
        return ResponseGagal.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
