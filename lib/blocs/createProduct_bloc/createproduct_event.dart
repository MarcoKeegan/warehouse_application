part of 'createproduct_bloc.dart';

abstract class CreateproductEvent extends Equatable {
  const CreateproductEvent();

  @override
  List<Object> get props => [];
}

class CreateProductReq extends CreateproductEvent {
  final int productTypeId;
  final String productName;
  final String price;
  final Uint8List image64;
  final String imageType;
  final String firebaseUid;

  CreateProductReq(
      {required this.productTypeId,
      required this.productName,
      required this.price,
      required this.image64,
      required this.imageType,
      required this.firebaseUid});

  @override
  List<Object> get props =>
      [productTypeId, productName, price, image64, imageType, firebaseUid];
}
