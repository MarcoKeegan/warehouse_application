part of 'deleteproduct_bloc.dart';

abstract class DeleteproductEvent extends Equatable {
  const DeleteproductEvent();

  @override
  List<Object> get props => [];
}

class DisableProduct extends DeleteproductEvent {
  final String firebaseUid;
  final int productId;
  // final bool softDelete;

  DisableProduct({
    required this.firebaseUid,
    required this.productId,
    // required this.softDelete,
  });

  @override
  List<Object> get props => [
        firebaseUid,
        productId,
        // softDelete,
      ];
}
