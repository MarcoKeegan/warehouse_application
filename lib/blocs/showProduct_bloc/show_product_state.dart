part of 'show_product_bloc.dart';

abstract class ShowProductState extends Equatable {
  const ShowProductState();

  @override
  List<Object> get props => [];
}

class ShowProductInitial extends ShowProductState {}

class ShowProductFailed extends ShowProductState {}

class ShowProductLoading extends ShowProductState {}

class ShowProductDone extends ShowProductState {
  final ReadAllProduct product;

  ShowProductDone({required this.product});

  @override
  List<Object> get props => [product];
}
