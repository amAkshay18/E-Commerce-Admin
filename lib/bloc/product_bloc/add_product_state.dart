part of 'add_product_bloc.dart';

class AddProductState {}

class AddImageState extends AddProductState {
  File imagestate;
  AddImageState({required this.imagestate});
}

class AddProductDataState extends AddProductState {
  ProductClass productStateObj;
  AddProductDataState({required this.productStateObj});
}

class FirebaseProductState extends AddProductState {
  List<ProductClass> listProduct;
  FirebaseProductState({required this.listProduct});
}

class ProductLoadingState extends AddProductState {}

class ProductFetchSuccessState extends AddProductState {
  final List<ProductClass> products;

  ProductFetchSuccessState({required this.products});
}

class ProductFetchErrorState extends AddProductState {
  final String error;

  ProductFetchErrorState({required this.error});
}

class ProductEditLoadingState extends AddProductState {}

class ProductEditSuccessState extends AddProductState {}
