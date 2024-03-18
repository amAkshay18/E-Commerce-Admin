import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafloom_admin/data/product_functions/image_picker.dart';
import 'package:leafloom_admin/data/product_functions/product_adding_function.dart';
import 'package:leafloom_admin/data/product_functions/product_edit.dart';
import 'package:leafloom_admin/data/product_functions/product_fetching.dart';
import 'package:leafloom_admin/models/product_model.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

CollectionReference reference =
    FirebaseFirestore.instance.collection('shopping_list');

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState()) {
    on<AddImageEvent>(
      (event, emit) async {
        final imgPath = await takeImg();
        if (imgPath == null) return;
        emit(
          AddImageState(imagestate: File(imgPath)),
        );
      },
    );
    on<FirebaseAddEvent>(
      (event, emit) async {
        emit(ProductEditLoadingState());
        final imgUrl = await uploadImageToFirebase(imageFile: event.imageFile);
        // ignore: use_build_context_synchronously
        await addProductToFirebase(
          imgUrl: imgUrl,
          product: event.product,
          context: event.context,
        );
        emit(AddProductDataState(productStateObj: event.product));
      },
    );
    on<FirebaseProductEvent>((event, emit) async {
      List<ProductClass> products = fetchProducts() as List<ProductClass>;
      emit(
        FirebaseProductState(listProduct: products),
      );
    });

    on<ProductFetchEvent>(_productFetchEvent);
    on<ProductEditEvent>(_productEditEvent);
  }

  FutureOr<void> _productFetchEvent(
      ProductFetchEvent event, Emitter<AddProductState> emit) async {
    emit(ProductLoadingState());
    final response = await fetchProducts();
    if (response.isEmpty) {
      emit(ProductFetchErrorState(error: 'Products empty'));
    } else {
      emit(ProductFetchSuccessState(products: response));
    }
  }

  FutureOr<void> _productEditEvent(
      ProductEditEvent event, Emitter<AddProductState> emit) async {
    log('${event.product.id} +++++++++++++++++++++++++++++++++++++++++++++++++--------------=======================================>>>>>>>>>>');
    emit(ProductEditLoadingState());
    if (!event.imageFile.contains('https')) {
      event.product.imageUrl =
          await uploadImageToFirebase(imageFile: File(event.imageFile));
    }
    await editProductToFirebase(product: event.product, context: event.context);
    emit(ProductEditSuccessState());
  }
}
