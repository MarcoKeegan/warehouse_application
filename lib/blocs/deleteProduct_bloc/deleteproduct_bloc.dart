import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/repo/repositories/deleteProduct_repository.dart';

part 'deleteproduct_event.dart';
part 'deleteproduct_state.dart';

class DeleteproductBloc extends Bloc<DeleteproductEvent, DeleteproductState> {
  DeleteproductBloc({required this.deleteProductRepository})
      : super(DeleteproductInitial());

  final DeleteProductRepository deleteProductRepository;

  @override
  Stream<DeleteproductState> mapEventToState(
    DeleteproductEvent event,
  ) async* {
    if (event is DisableProduct) {
      yield DeleteProductLoading();
      try {
        await deleteProductRepository.deleteProduct(
          firebaseUid: event.firebaseUid,
          idProduct: event.productId,
          softDelete: event.softDelete,
        );
        yield DeleteProductDone();
      } catch (e) {
        yield DeleteProductFailed();
      }
    }
  }
}
