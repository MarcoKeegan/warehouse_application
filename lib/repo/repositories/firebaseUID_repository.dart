import 'package:warehouse_application/models/firebaseUid_models.dart';
import 'package:warehouse_application/models/firebaseUser_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class FirebaseUIDRepository {
  FirebaseUIDRepository({WarehouseApiProvider? warehouseApiProvider})
      : _warehouseApiProvider = warehouseApiProvider ?? WarehouseApiProvider();

  final WarehouseApiProvider _warehouseApiProvider;

  Future loginToDash({required FirebaseUser firebaseUser}) async {
    final result = await _warehouseApiProvider.loginUser(firebaseUser.uid);
    if (result is ReadUserFirebaseUID) {
      print(result.message);
      return result.data;
    } else if (result is ResponseGagal) {
      print(result.errorkey);
    }
  }
}