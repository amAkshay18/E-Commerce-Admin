import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafloom_admin/bloc/product_bloc/add_product_bloc.dart';
import 'package:leafloom_admin/models/product_model.dart';
import 'package:leafloom_admin/view/home/home.dart';
import 'package:leafloom_admin/view/product/screen/adding_screen.dart';
import 'package:leafloom_admin/view/product/screen/product_discription.dart';

// ignore: must_be_immutable
class AddProductCard extends StatefulWidget {
  AddProductCard({
    super.key,
    required this.product,
    required this.delete,
  });

  VoidCallback delete;
  final ProductClass product;

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> {
  late int parsedPrice;

  @override
  void initState() {
    super.initState();

    parsedPrice = int.parse(widget.product.price ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDiscription(
                  product: widget.product,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 3,
                  width: 340,
                  child: Image.network(
                    widget.product.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(gradient: gcolor),
                  child: ListTile(
                    leading: Text(
                      widget.product.name ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductScreen(
                                  product: widget.product,
                                ),
                              ),
                            );
                          },
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () async {
                            _showMyDialog(context: context);
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog({context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text('Are sure you want to delete'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Products')
                    .doc(widget.product.id)
                    .delete()
                    .whenComplete(() => context
                        .read<AddProductBloc>()
                        .add(ProductFetchEvent()));
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
