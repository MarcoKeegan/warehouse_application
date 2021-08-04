import 'package:warehouse_application/models/userRole_model.dart';
// import 'package:warehouse_application/repo/provider/roleApi_Provider.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetRoleFailure implements Exception {}

class RoleApiRepository {
  RoleApiRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<UserRole>> getRole({int? roleId}) async {
    try {
      final result = await _provider.getRole(roleId ?? 1);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetRoleFailure();
    }
  }
}
