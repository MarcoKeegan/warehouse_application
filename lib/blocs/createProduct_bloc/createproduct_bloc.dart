import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/repo/repositories/createProduct_repository.dart';

part 'createproduct_event.dart';
part 'createproduct_state.dart';

class CreateproductBloc extends Bloc<CreateproductEvent, CreateproductState> {
  CreateproductBloc({required this.createProductRepository}) : super(CreateproductInitial());

  final CreateProductRepository createProductRepository;

  @override
  Stream<CreateproductState> mapEventToState(
    CreateproductEvent event,
  ) async* {
    if (event is CreateProductReq) {
      yield CreateproductLoading();
      try {
        await createProductRepository.createProduct(productTypeId: event.productTypeId, productName: event.productName, price: event.price, image64: event.image64, imageType: event.imageType);
        yield CreateproductDone();
      } catch (e) {
        yield CreateproductFailed();
      }
    }
  }
}
