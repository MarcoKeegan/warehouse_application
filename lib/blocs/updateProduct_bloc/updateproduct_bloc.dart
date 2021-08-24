import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/repo/repositories/updateProduct_repository.dart';

part 'updateproduct_event.dart';
part 'updateproduct_state.dart';

class UpdateproductBloc extends Bloc<UpdateproductEvent, UpdateproductState> {
  UpdateproductBloc({required this.updateProductRepository})
      : super(UpdateproductInitial());

  final UpdateProductRepository updateProductRepository;

  @override
  Stream<UpdateproductState> mapEventToState(
    UpdateproductEvent event,
  ) async* {
    if (event is UpdateProductReq) {
      yield UpdateproductLoading();
      try {
        Uint8List imageToUpladBytes = event.image64;
        String image64 = base64Encode(imageToUpladBytes);
        print(event.imageType);

        ImageProduct image =
            ImageProduct(imageType: event.imageType, image64: image64);

        await updateProductRepository.updateProduct(
            productTypeId: event.productTypeId,
            productName: event.productName,
            price: event.price,
            images: image,
            firebaseUid: event.firebaseUid,
            idProduct: event.productId);

        yield UpdateproductDone();
      } on UpdateProductInvalidProductId {
        yield UpdateproductInvalidProductId();
      } on UpdateProductErrorParam {
        yield UpdateproductErrorParam();
      } on UpdateProductErrorContentType {
        yield UpdateproductContentType();
      } on UpdateProductErrorInternalServer {
        yield UpdateproductInternalServer();
      } on UpdateProductInvalidUid {
        yield UpdateproductInvalidUid();
        // } catch (e) {
        //   yield UpdateproductFailed();
      }
    }
  }
}
