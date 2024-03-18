part of 'add_product_bloc.dart';

class AddProductEvent {}

class AddImageEvent extends AddProductEvent {}

class ProductFetchEvent extends AddProductEvent {}

class FirebaseAddEvent extends AddProductEvent {
  BuildContext context;
  ProductClass product;
  File imageFile;
  FirebaseAddEvent(
      {required this.context, required this.product, required this.imageFile});
}

class FirebaseProductEvent extends AddProductEvent {}

class ProductEditEvent extends AddProductEvent {
  BuildContext context;
  ProductClass product;
  String imageFile;
  ProductEditEvent(
      {required this.context, required this.product, required this.imageFile});
}
