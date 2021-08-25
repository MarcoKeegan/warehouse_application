part of 'deleteproduct_bloc.dart';

abstract class DeleteproductState extends Equatable {
  const DeleteproductState();

  @override
  List<Object> get props => [];
}

class DeleteproductInitial extends DeleteproductState {}

class DeleteProductLoading extends DeleteproductState {}

class DeleteProductDone extends DeleteproductState {}

// class DeleteProductFailed extends DeleteproductState {}

class DeleteProductFailedInvalidProductId extends DeleteproductState {}

class DeleteProductErrorInternalServer extends DeleteproductState {}

class DeleteProductFailedInvalidUid extends DeleteproductState {}
