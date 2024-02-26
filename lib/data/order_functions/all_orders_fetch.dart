import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/models/order_model.dart';

Future<List<OrderModel>> fetchOrder() async {
  List<OrderModel> productList = [];
  try {
    var orderCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Order').get();

    if (orderCollectionSnapshot.docChanges.isNotEmpty) {
      productList = orderCollectionSnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data();
          return OrderModel.fromJson(data);
        },
      ).toList();
    } else {
      debugPrint("Error:order collection snapshot is null");
    }
  } catch (e) {
    debugPrint("Error fetching order===+++++++====: $e");
  }
  return productList;
}
