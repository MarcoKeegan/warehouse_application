import 'package:meta/meta.dart';
import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class GetProductFailure implements Exception {}

class CreateProductRepository {
  CreateProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ResponseBerhasil> createProduct({
    required int productTypeId,
    required String productName,
    required int price,
    required String image64,
    required String imageType,
  }) async {
    CreateProduct createProduct = CreateProduct(
        imageType: imageType,
        price: price,
        productName: productName,
        productTypeId: productTypeId,
        image64: image64);

    final result = await _provider.createProduct(createProduct);
    if (result is ResponseBerhasil) {
      return result;
    } else if (result is ResponseGagal) {
      throw GetProductFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
