import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_application/models/createProduct_models.dart';
import 'package:warehouse_application/repo/repositories/createProduct_repository.dart';

part 'createproduct_event.dart';
part 'createproduct_state.dart';

class CreateproductBloc extends Bloc<CreateproductEvent, CreateproductState> {
  CreateproductBloc({required this.createProductRepository})
      : super(CreateproductInitial());

  final CreateProductRepository createProductRepository;

  @override
  Stream<CreateproductState> mapEventToState(
    CreateproductEvent event,
  ) async* {
    if (event is CreateProductReq) {
      yield CreateproductLoading();
      try {
        Uint8List imageToUploadBytes = event.image64;
        String image64 = base64Encode(imageToUploadBytes);
        // String imageType = lookupMimeType(event.imageType)!.split('/').last;
        print(event.imageType);

        ImageProduct images =
            ImageProduct(image64: image64, imageType: event.imageType);

        await createProductRepository.createProduct(
          productTypeId: event.productTypeId,
          productName: event.productName,
          price: event.price,
          images: images,
          firebaseUid: event.firebaseUid,
        );
        yield CreateproductDone();
      } catch (e) {
        yield CreateproductFailed();
      }
    }
  }
}
