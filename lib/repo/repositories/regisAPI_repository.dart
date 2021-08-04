import 'package:warehouse_application/models/registerUser_model.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetUserRegisterFailure implements Exception {}

class RegisApiRepository {
  RegisApiRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ResponseBerhasil> regisUser(
      {required String email,
      required String pass,
      required String name,
      required int roleId}) async {
    RegisUser regis =
        RegisUser(email: email, pass: pass, name: name, roleId: roleId);

    final result = await _provider.regisUser(regis);
    if (result is ResponseBerhasil) {
      return result;
    } else if (result is ResponseGagal) {
      throw GetUserRegisterFailure();
    } else {
      throw Exception();
    }
  }
}
