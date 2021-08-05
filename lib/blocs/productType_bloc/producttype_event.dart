part of 'producttype_bloc.dart';

abstract class ProducttypeEvent extends Equatable {
  const ProducttypeEvent();

  @override
  List<Object> get props => [];
}

class LoadProductType extends ProducttypeEvent {
  final int productId;

  LoadProductType({int? productId}) : productId = productId ?? 4;

  @override
  List<Object> get props => [productId];
}