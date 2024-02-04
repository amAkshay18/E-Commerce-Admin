part of 'add_product_bloc.dart';

class AddProductState {}

class AddImageState extends AddProductState {
  File imagestate;
  AddImageState({required this.imagestate});
}

class AddProductDataState extends AddProductEvent {
  ProductClass productStateObj;
  AddProductDataState({required this.productStateObj});
}

class FirebaseProductState extends AddProductState {
  List<ProductClass> listProduct;
  FirebaseProductState({required this.listProduct});
}
