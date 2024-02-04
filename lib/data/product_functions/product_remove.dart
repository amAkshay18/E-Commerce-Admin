import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 100.0),
    content: Text(message),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> deleteProduct(
    {required String id, required BuildContext context}) async {
  print('================');
  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  await products.doc(id).delete().then(
    (value) {
      log("Product Deleted");
      showSnackbar(context, "Product was deleted");
    },
  ).catchError(
    (error) {
      log("Failed to delete product: $error");
      showSnackbar(context, "Failed to delete product");
    },
  );
}
