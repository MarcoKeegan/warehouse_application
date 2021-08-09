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
    required String price,
    required ImageProduct images,
    required String firebaseUid,
  }) async {
    CreateProduct createProduct = CreateProduct(
        price: price,
        productName: productName,
        productTypeId: productTypeId,
        images: images,
        );

    final result = await _provider.createProduct(createProduct, firebaseUid);
    if (result is ResponseBerhasil) {
      print(result.message);
      return result;
    } else if (result is ResponseGagal) {
      print(result.errorkey);
      throw GetProductFailure();
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
