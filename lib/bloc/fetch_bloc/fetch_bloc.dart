import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafloom_admin/bloc/fetch_bloc/fetch_state.dart';
import 'package:leafloom_admin/data/product_functions/product_fetching.dart';
import 'package:leafloom_admin/models/product_model.dart';

part 'fetch_event.dart';
// part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial()) {
    on<ProductFetchEvent>((event, emit) async {
      List<ProductClass> productFetch = await fetchProducts();
      // ignore: avoid_print
      print('----------------${productFetch.length}');
      emit(FirebaseFetchProductState(listofProducts: productFetch));
    });
  }
}
