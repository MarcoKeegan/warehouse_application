import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:warehouse_application/models/readAllUser_model.dart';

class LoginRegisterProvider {
  LoginRegisterProvider({http.Client? login}) : _login = login ?? http.Client();

  final http.Client _login;
  final String _baseUrl = "https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0/user/User_all";

  Future<AllUser> userRegister(int amount) async {
    final Uri _url = Uri.parse('$_baseUrl');
    try {
      final http.Response response = await _login.post(_url);
      if (response.statusCode == 200) {
        return AllUser.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    }catch (e) {
      throw Exception(e);
    }
  }
}