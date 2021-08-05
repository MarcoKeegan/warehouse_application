import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/productType_models.dart';
import 'package:warehouse_application/repo/repositories/productTypeApi_repository.dart';

part 'producttype_event.dart';
part 'producttype_state.dart';

class ProducttypeBloc extends Bloc<ProducttypeEvent, ProducttypeState> {
  ProducttypeBloc({required this.productTypeRepository}) : super(ProducttypeInitial()) {
    add(LoadProductType(productId: 4));
  }

  final ProductTypeRepository productTypeRepository;

  @override
  Stream<ProducttypeState> mapEventToState(
    ProducttypeEvent event,
  ) async* {
    if (event is LoadProductType) {
      yield ProducttypeLoading();
      try {
        final result = await productTypeRepository.getProductType(productId: event.productId);
        yield ProducttypeDone(type: result);
      } catch (e) {
        yield ProducttypeFailed();
      }
    }
  }
}
