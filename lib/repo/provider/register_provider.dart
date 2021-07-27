import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:warehouse_application/models/registerUser_model.dart';

class RegisterProvider {
  RegisterProvider({http.Client? register}) : _regis = register ?? http.Client();

  final http.Client _regis;
  final String _baseUrl = "https://asia-east2-warehouse-intern.cloudfunctions.net/Apiv1_1_0/user/Create_user";

  Future<Body> userRegister(int amount) async {
    final Uri _url = Uri.parse('$_baseUrl');

    try {
      final http.Response response = await _regis.post(_url);
      if (response.statusCode == 200) {
        return Body.fromJson(jsonDecode(response.body));
      }
      throw Exception(response.statusCode);
    }catch (e) {
      throw Exception(e);
    }
  }
}