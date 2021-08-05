part of 'createproduct_bloc.dart';

abstract class CreateproductState extends Equatable {
  const CreateproductState();
  
  @override
  List<Object> get props => [];
}

class CreateproductInitial extends CreateproductState {}

class CreateproductLoading extends CreateproductState {}

class CreateproductDone extends CreateproductState {}

class CreateproductFailed extends CreateproductState {}
