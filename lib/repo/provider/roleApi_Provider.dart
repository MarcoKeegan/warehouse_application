import 'dart:convert';

import 'package:warehouse_application/models/userRole_model.dart';
import 'package:http/http.dart' as http;

class RoleApiProvider {
  RoleApiProvider({http.Client? role}) : _role = role ?? http.Client();

  final http.Client _role;
  final String _baseUrl = "https://asia-east2-warehouse-intern.cloudfunctions.net/fransTest/user/User_role";

  Future<UserPack> getRole(int roleId) async {
    final Uri _url = Uri.parse('$_baseUrl');

    try {
      final http.Response response = await _role.get(_url);
      if (response.statusCode == 200) {
        return UserPack.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    }catch (e) {
      throw Exception(e);
    }
  }
}