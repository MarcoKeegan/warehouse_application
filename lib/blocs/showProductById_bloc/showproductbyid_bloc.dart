import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/readProductById_models.dart';
import 'package:warehouse_application/repo/repositories/readProductById_repository.dart';

part 'showproductbyid_event.dart';
part 'showproductbyid_state.dart';

class ShowproductbyidBloc
    extends Bloc<ShowproductbyidEvent, ShowproductbyidState> {
  ShowproductbyidBloc({required this.getProductByIdRepository})
      : super(ShowproductbyidInitial());
  // add(ShowProductByIdLoad());

  final GetProductByIdRepository getProductByIdRepository;

  @override
  Stream<ShowproductbyidState> mapEventToState(
    ShowproductbyidEvent event,
  ) async* {
    if (event is ShowProductByIdLoad) {
      yield ShowproductbyidLoading();
      try {
        final result = await getProductByIdRepository.getAllProductById(
            productId: event.productId);
        yield ShowproductbyidDone(productID: result);
      } on GetProductByIdFailureInvalidProductId {
        yield ShowproductbyidFailedById();
      } on GetProductByIdFailureErrorParam {
        yield ShowproductbyidErrorParam();
      } on GetProductByIdFailureErrorContentType {
        yield ShowproductbyidErrorContentType();
      } on GetProductByIdFailureErrorInternalServer {
        yield ShowproductbyidErrorInternalServer();
        // } catch (e) {
        //   yield ShowproductbyidFailed();
      }
    }
  }
}
