part of 'showproductbyid_bloc.dart';

abstract class ShowproductbyidState extends Equatable {
  const ShowproductbyidState();

  @override
  List<Object> get props => [];
}

class ShowproductbyidInitial extends ShowproductbyidState {}

class ShowproductbyidFailed extends ShowproductbyidState {}

class ShowproductbyidFailedById extends ShowproductbyidState {}

class ShowproductbyidErrorParam extends ShowproductbyidState {}

class ShowproductbyidErrorContentType extends ShowproductbyidState {}

class ShowproductbyidErrorInternalServer extends ShowproductbyidState {}

class ShowproductbyidLoading extends ShowproductbyidState {}

class ShowproductbyidDone extends ShowproductbyidState {
  final ReadProductId productID;

  ShowproductbyidDone({required this.productID});

  @override
  List<Object> get props => [productID];
}
