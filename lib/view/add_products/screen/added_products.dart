import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/data/product_functions/product_remove.dart';
import 'package:leafloom_admin/models/product_model.dart';
import 'package:leafloom_admin/view/add_products/screen/adding_screen.dart';
import 'package:leafloom_admin/view/add_products/screen/editing_screen.dart';
import 'package:leafloom_admin/view/add_products/widget/added_product_card.dart';

class ScreenAddedProducts extends StatefulWidget {
  const ScreenAddedProducts({
    super.key,
  });

  @override
  State<ScreenAddedProducts> createState() => _ScreenAddedProductsState();
}

class _ScreenAddedProductsState extends State<ScreenAddedProducts> {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: ProductBody(productRef: productRef),
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  const ProductBody({
    super.key,
    required this.productRef,
  });

  final CollectionReference<Object?> productRef;

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: StreamBuilder(
              stream: widget.productRef.snapshots(),
              builder: (context, snapshot) {
                // ignore: avoid_print
                print(
                    'Connection State: ==========${snapshot.connectionState}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Text('Error:----------- ${snapshot.error}');
                }

                // ignore: avoid_print
                print('Data: ${snapshot.data}');
                List<QueryDocumentSnapshot<Object?>> data = [];
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Add Products'),
                  );
                }
                data = snapshot.data!.docs;
                if (snapshot.data!.docs.isEmpty || data.isEmpty) {
                  return const Center(
                    child: Text('No Products'),
                  );
                }
                // print(
                //   '--------------------${data.length}',
                // );

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AddProductCard(
                      id: data[index]['id'],
                      category: data[index]['category'] ?? 'null data',
                      discription: data[index]['description'] ?? 'null data',
                      price: data[index]['price'] ?? 'null Data',
                      delete: () {
                        deleteProduct(
                          id: data[index].id,
                          context: context,
                        );
                      },
                      edit: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ScreenEditing(
                              id: data[index]['id'],
                            );
                          },
                        );
                      },
                      img: data[index]['imageUrl'] ??
                          'https://static.wikia.nocookie.net/black-plasma-studios/images/a/ad/Null_-_Profile.jpg/revision/latest?cb=20170612234434',
                      name: data[index]['name'] ?? 'name',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 25,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

Future<List<ProductClass>> fetchProducts() async {
  try {
    var userCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    return userCollectionSnapshot.docs.map(
      (doc) {
        Map<String, dynamic> data = doc.data();
        return ProductClass.fromJson(data);
      },
    ).toList();
  } catch (e) {
    // print("Error fetching products: $e");
    return [];
  }
}
