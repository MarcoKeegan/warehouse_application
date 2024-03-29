import 'package:warehouse_application/models/readProductById_models.dart';
import 'package:warehouse_application/models/response_model.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';
import 'package:warehouse_application/repo/repositories/readProduct_repository.dart';

class GetProductByIdFailure implements Exception {}

class GetProductByIdFailureInvalidProductId implements GetProductByIdFailure {}

class GetProductByIdFailureErrorParam implements GetProductByIdFailure {}

class GetProductByIdFailureErrorContentType implements GetProductByIdFailure {}

class GetProductByIdFailureErrorInternalServer
    implements GetProductByIdFailure {}

class GetProductByIdRepository {
  GetProductByIdRepository({WarehouseApiProvider? provider})
      : _provider = provider ?? WarehouseApiProvider();

  final WarehouseApiProvider _provider;

  Future<ReadProductId> getAllProductById({productId}) async {
    // try {
    final result = await _provider.getAllProductById(productId);
    if (result is ReadProductId) {
      return result;
    } else if (result is ResponseGagal) {
      switch (result.errorkey) {
        case "error_invalid_product_id":
          throw GetProductByIdFailureInvalidProductId();
        case "error_param":
          throw GetProductByIdFailureErrorParam();
        case "error_content-type":
          throw GetProductByIdFailureErrorContentType();
        case "error_internal_server":
          throw GetProductByIdFailureErrorInternalServer();

        default:
          throw GetProductByIdFailure();
      }
    } else {
      throw Exception();
    }
    // } catch (e) {
    //   print(e.toString());
    //   throw GetProductFailure();
  }
}
// }
