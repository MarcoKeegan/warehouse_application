import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/readProduct_models.dart';
import 'package:warehouse_application/repo/repositories/readProduct_repository.dart';

part 'show_product_event.dart';
part 'show_product_state.dart';

class ShowProductBloc extends Bloc<ShowProductEvent, ShowProductState> {
  ShowProductBloc({required this.getProductRepository})
      : super(ShowProductInitial()) {
    add(ShowProductLoad());
  }

  final GetProductRepository getProductRepository;

  @override
  Stream<ShowProductState> mapEventToState(
    ShowProductEvent event,
  ) async* {
    if (event is ShowProductLoad) {
      yield ShowProductLoading();
      try {
        final result =
            await getProductRepository.getProduct(productId: 1);
        yield ShowProductDone(product: result);
      } catch (e) {
        yield ShowProductFailed();
      }
    }
  }
}
