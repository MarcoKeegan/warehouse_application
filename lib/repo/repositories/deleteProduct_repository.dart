import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class DeleteProductFailure implements Exception {}

class DeleteProductInvalidProductId implements DeleteProductFailure {}

class DeleteProductErrorrInternalServer implements DeleteProductFailure {}

class DeleteProductInvalidUid implements DeleteProductFailure {}

class DeleteProductRepository {
  DeleteProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ResponseBerhasil> deleteProduct({
    required int idProduct,
    required String firebaseUid,
    // required bool softDelete,
  }) async {
    final result = await _provider.deleteProduct(
      firebaseUid,
      idProduct,
    );

    if (result is ResponseBerhasil) {
      return result;
    } else if (result is ResponseGagal) {
      switch (result.errorkey) {
        case "error_invalid_product_id":
          throw DeleteProductInvalidProductId();
        case "error_internal_server":
          throw DeleteProductErrorrInternalServer();
        case "error_invalid_uid":
          throw DeleteProductInvalidUid();

        default:
          throw DeleteProductFailure();
      }
    } else {
      throw Exception();
    }
  }
}
