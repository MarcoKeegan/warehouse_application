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
        // String imageType;
        // String image64;
        ImageProduct? image;
        // = ImageProduct(imageType: imageType, image64: image64);

        if (event.imageType == null && event.imageType != null) {
          image = null;
        } else if (event.image64 != null && event.imageType != null) {
          image = ImageProduct(image64: base64Encode(event.image64!), imageType: event.imageType);
        } else {
          yield UpdateproductFailed();
          throw Exception();
        }
        // Uint8List imageToUpladBytes = event.image64;
        // print(event.imageType);

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
