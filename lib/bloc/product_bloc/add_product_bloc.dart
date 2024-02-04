import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafloom_admin/data/product_functions/image_picker.dart';
import 'package:leafloom_admin/data/product_functions/product_adding_function.dart';
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
        emit(
          AddImageState(imagestate: imgPath),
        );
      },
    );
    on<FirebaseAddEvent>(
      (event, emit) async {
        final imgUrl = await uploadImageToFirebase(imageFile: event.imageFile);
        // ignore: use_build_context_synchronously
        await addProductToFirebase(
          imgUrl: imgUrl,
          product: event.product,
          context: event.context,
        );
        emit(
          AddProductDataState(productStateObj: event.product)
              as AddProductState,
        );
      },
    );
    on<FirebaseProductEvent>((event, emit) async {
      List<ProductClass> products = fetchProducts() as List<ProductClass>;
      emit(
        FirebaseProductState(listProduct: products),
      );
    });
  }
}
