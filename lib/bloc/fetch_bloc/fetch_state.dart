// library fetch_library;

import 'package:leafloom_admin/models/product_model.dart';

sealed class FetchState {}

final class FetchInitial extends FetchState {}

final class FirebaseFetchProductState extends FetchInitial {
  List<ProductClass> listofProducts;
  FirebaseFetchProductState({required this.listofProducts});
}
