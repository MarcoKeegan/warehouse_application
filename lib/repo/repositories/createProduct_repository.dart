import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class CreateProductFailure implements Exception {}

class CreateProductOthersFailures implements CreateProductFailure {}

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
      switch (result.errorkey) {
        case "error_invalid_product_id":
          throw CreateProductOthersFailures();
        case "error_param":
          throw CreateProductOthersFailures();
        case "error_content-type":
          throw CreateProductOthersFailures();
        case "error_internal_server":
          throw CreateProductOthersFailures();
        case "error_invalid_uid":
          throw CreateProductOthersFailures();

        default:
          throw CreateProductFailure();
      }
    } else {
      throw Exception();
    }
  }
}
