import 'package:warehouse_application/models/productType_models.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetProductTypeFailure implements Exception {}

class ProductTypeRepository {
  ProductTypeRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<List<ProductType>> getProductType({int? productId}) async {
    try {
      final result = await _provider.getProductType(productId ?? 1);
      print(result.message);
      return result.data;
    } catch (e) {
      print(e.toString());
      throw GetProductTypeFailure();
    }
  }
}