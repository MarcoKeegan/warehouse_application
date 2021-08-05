part of 'producttype_bloc.dart';

abstract class ProducttypeState extends Equatable {
  const ProducttypeState();
  
  @override
  List<Object> get props => [];
}

class ProducttypeInitial extends ProducttypeState {}

class ProducttypeFailed extends ProducttypeState {}

class ProducttypeLoading extends ProducttypeState {}

class ProducttypeDone extends ProducttypeState {
  final List<ProductType> type;

  ProducttypeDone({required this.type});

  @override
  List<Object> get props => [type];
}