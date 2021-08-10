import 'package:warehouse_application/models/readProduct_models.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetProductFailure implements Exception {}

class GetProductRepository {
  GetProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<ProductData>> getProduct({productId}) async {
    try {
      final result = await _provider.getProduct(productId);
      print(result.message);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetProductFailure();
    }
  }
}