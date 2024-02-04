import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/add_products/screen/editing_screen.dart';
import 'package:leafloom_admin/view/add_products/screen/product_discription.dart';
import 'package:leafloom_admin/view/home/home.dart';

// ignore: must_be_immutable
class AddProductCard extends StatefulWidget {
  AddProductCard(
      {super.key,
      required this.name,
      required this.img,
      required this.delete,
      required this.edit,
      required this.price,
      required this.category,
      required this.discription,
      required this.id});
  final String name;
  final String img;
  final String id;
  final String price;
  final String category;
  final String discription;
  VoidCallback edit;
  VoidCallback delete;

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> {
  late int parsedPrice;

  @override
  void initState() {
    super.initState();

    parsedPrice = int.parse(widget.price);
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
                  id: widget.id,
                  img: widget.img,
                  category: widget.category,
                  discription: widget.discription,
                  name: widget.name,
                  price: widget.price,
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
                  // decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(gradient: gcolor),
                  child: ListTile(
                    leading: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ScreenEditing(
                                  id: widget.id,
                                );
                              },
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
                    .doc(widget.id)
                    .delete();
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
