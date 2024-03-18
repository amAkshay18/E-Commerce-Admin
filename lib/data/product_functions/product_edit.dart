import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/data/product_functions/product_adding_function.dart';
import 'package:leafloom_admin/models/product_model.dart';

Future<void> editProductToFirebase({
  required ProductClass product,
  required BuildContext? context,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection('Products')
        .doc(product.id)
        .update(
      {
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
        'description': product.description,
        'category': product.category,
        'imageUrl': product.imageUrl,
        'id': product.id,
        'searchName': product.searchName,
      },
    );
  } on FirebaseException catch (error) {
    String errorMessage = 'An error occurred while adding the product.';

    if (error.code == 'permission-denied') {
      errorMessage =
          'Permission denied. You do not have the necessary permissions.';
    } else if (error.code == 'not-found') {
      errorMessage = 'The requested document was not found.';
    }

    // ignore: use_build_context_synchronously
    showSnackbar(context!, errorMessage);
    // ignore: avoid_print
    print("Failed to add product: $error");
  } catch (error) {
    // Handle generic exceptions, e.g., network issues
    // ignore: use_build_context_synchronously
    showSnackbar(context!, 'An unexpected error occurred. Please try again.');
    // ignore: avoid_print
    print("Failed to add product: $error");
  }
}
