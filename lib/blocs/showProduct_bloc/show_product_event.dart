part of 'show_product_bloc.dart';

abstract class ShowProductEvent extends Equatable {
  const ShowProductEvent();

  @override
  List<Object> get props => [];
}

class ShowProductLoad extends ShowProductEvent {
  final int productId;

  ShowProductLoad({int? productId}) : productId = productId ?? 5;

  @override
  List<Object> get props => [productId];
}
