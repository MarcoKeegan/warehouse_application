import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class UpdateProductFailure implements Exception {}

class UpdateProductInvalidProductId implements UpdateProductFailure {}

class UpdateProductErrorParam implements UpdateProductFailure {}

class UpdateProductErrorContentType implements UpdateProductFailure {}

class UpdateProductErrorInternalServer implements UpdateProductFailure {}

class UpdateProductInvalidUid implements UpdateProductFailure {}

class UpdateProductRepository {
  UpdateProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ResponseBerhasil> updateProduct({
    required int productTypeId,
    required String productName,
    required String price,
    ImageProduct? images,
    required String firebaseUid,
    required int idProduct,
  }) async {
    CreateProduct updateProduct = CreateProduct(
      productTypeId: productTypeId,
      productName: productName,
      price: price,
      images: images,
    );

    final result = await _provider.updateProduct(
      updateProduct,
      idProduct,
      firebaseUid,
    );

    if (result is ResponseBerhasil) {
      return result;
    } else if (result is ResponseGagal) {
      switch (result.errorkey) {
        case "error_invalid_product_id":
          throw UpdateProductInvalidProductId();
        case "error_param":
          throw UpdateProductErrorParam();
        case "error_content-type-type":
          throw UpdateProductErrorContentType();
        case "error_internal_server":
          throw UpdateProductErrorInternalServer();
        case "error_invalid_uid":
          throw UpdateProductInvalidUid();

        default:
          throw UpdateProductFailure();
      }
    } else {
      throw Exception();
    }
  }

  Future<String> networkImageToBase64({required String imageUrl}) async {
    return _provider.networkImageToBase64(imageUrl);
  }
}
