part of 'showproductbyid_bloc.dart';

abstract class ShowproductbyidEvent extends Equatable {
  const ShowproductbyidEvent();

  @override
  List<Object> get props => [];
}

class ShowProductByIdLoad extends ShowproductbyidEvent {
  final int productId;

  ShowProductByIdLoad({required this.productId});

  @override
  List<Object> get props => [productId];
}
