part of 'updateproduct_bloc.dart';

abstract class UpdateproductState extends Equatable {
  const UpdateproductState();

  @override
  List<Object> get props => [];
}

class UpdateproductInitial extends UpdateproductState {}

class UpdateproductLoading extends UpdateproductState {}

class UpdateproductDone extends UpdateproductState {}

class UpdateproductFailed extends UpdateproductState {}
