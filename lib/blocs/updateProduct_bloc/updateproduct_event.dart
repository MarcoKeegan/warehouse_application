part of 'updateproduct_bloc.dart';

abstract class UpdateproductEvent extends Equatable {
  const UpdateproductEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProductReq extends UpdateproductEvent {
  final int productTypeId;
  final String productName;
  final String price;
  final Uint8List? image64;
  final String? imageType;
  final String firebaseUid;
  final int productId;
  // final String? imageUrl;

  UpdateProductReq(
      {required this.productTypeId,
      required this.productName,
      required this.price,
      this.image64,
      this.imageType,
      required this.firebaseUid,
      required this.productId,
      // this.imageUrl
      });

  @override
  List<Object?> get props => [
        productTypeId,
        productName,
        price,
        image64,
        imageType,
        firebaseUid,
        productId,
        // imageUrl,
      ];
}
