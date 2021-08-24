import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class CreateProductFailure implements Exception {}

class CreateProductFailureInvalidProductId implements CreateProductFailure {}

class CreateProductFailureErrorParam implements CreateProductFailure {}

class CreateProductFailureContentType implements CreateProductFailure {}

class CreateProductFailureInternalServer implements CreateProductFailure {}

class CreateProductFailureInvalidUid implements CreateProductFailure {}

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
          throw CreateProductFailureInvalidProductId();
        case "error_param":
          throw CreateProductFailureErrorParam();
        case "error_content-type":
          throw CreateProductFailureContentType();
        case "error_internal_server":
          throw CreateProductFailureInternalServer();
        case "error_invalid_uid":
          throw CreateProductFailureInvalidUid();

        default:
          throw CreateProductFailure();
      }
    } else {
      throw Exception();
    }
  }
}
