import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leafloom_admin/models/product_model.dart';

Future<List<ProductClass>> fetchProducts() async {
  List<ProductClass> productList = [];
  try {
    var productCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    productList = productCollectionSnapshot.docs.map(
      (doc) {
        Map<String, dynamic> data = doc.data();
        return ProductClass.fromJson(data);
      },
    ).toList();
  } catch (e) {
    // ignore: avoid_print
    print("Error fetching products: $e");
  }

  return productList;
}
