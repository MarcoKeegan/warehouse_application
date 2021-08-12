import 'package:warehouse_application/models/readProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetProductFailure implements Exception {}

class GetProductFailureInvalidProductId implements GetProductFailure {}

class GetProductRepository {
  GetProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ReadAllProduct> getAllProduct({readAllProduct}) async {
    try {
      final result = await _provider.getAllProduct(readAllProduct);
      if (result is ReadAllProduct) {
        return result;
      } else if (result is ResponseGagal) {
        switch (result.errorkey) {
          case "error_invalid_product_id": throw GetProductFailureInvalidProductId();

          default: throw GetProductFailure();
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw GetProductFailure();
    }
  }
}
