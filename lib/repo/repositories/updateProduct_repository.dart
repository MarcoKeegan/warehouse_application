import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class UpdateProductFailure implements Exception {}

class UpdateProductOthersFailure implements UpdateProductFailure {}

class UpdateProductRepository {
  UpdateProductRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ResponseBerhasil> updateProduct({
    required int productTypeId,
    required String productName,
    required String price,
    required ImageProduct images,
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
          throw UpdateProductOthersFailure();
        case "error_param":
          throw UpdateProductOthersFailure();
        case "error_content-type-type":
          throw UpdateProductOthersFailure();
        case "error_internal_server":
          throw UpdateProductOthersFailure();
        case "error_invalid_uid":
          throw UpdateProductOthersFailure();

        default:
          throw UpdateProductFailure();
      }
    } else {
      throw Exception();
    }
  }
}
