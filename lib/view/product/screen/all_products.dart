import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafloom_admin/bloc/product_bloc/add_product_bloc.dart';
import 'package:leafloom_admin/data/product_functions/product_remove.dart';
import 'package:leafloom_admin/models/product_model.dart';
import 'package:leafloom_admin/view/product/screen/adding_screen.dart';
import 'package:leafloom_admin/view/product/widget/added_product_card.dart';

class ScreenAllProducts extends StatefulWidget {
  const ScreenAllProducts({
    super.key,
  });

  @override
  State<ScreenAllProducts> createState() => _ScreenAddedProductsState();
}

class _ScreenAddedProductsState extends State<ScreenAllProducts> {
  @override
  void initState() {
    super.initState();
    context.read<AddProductBloc>().add(ProductFetchEvent());
  }

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
        body: const ProductBody(),
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  const ProductBody({
    super.key,
  });
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
            child: BlocBuilder<AddProductBloc, AddProductState>(
              builder: (context, state) {
                if (state is ProductFetchErrorState) {
                  return Text(state.error);
                } else if (state is ProductFetchSuccessState) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.products.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = state.products[index];
                      return AddProductCard(
                        product: data,
                        delete: () {
                          deleteProduct(
                            id: data.id!,
                            context: context,
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 25,
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
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
    return [];
  }
}
