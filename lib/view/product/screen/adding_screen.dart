import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leafloom_admin/bloc/product_bloc/add_product_bloc.dart';
import 'package:leafloom_admin/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, this.product});
  final ProductClass? product;
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();
  // File? pickedImageFile;

  String _imageUrl = '';
  String dropdownValue = 'Indoor';
  initializeControllers() {
    final product = widget.product;
    _imageUrl = product == null ? '' : product.imageUrl ?? '';
    setState(() {});
    _priceControllor =
        TextEditingController(text: product == null ? '' : product.price);
    _nameControllor =
        TextEditingController(text: product == null ? '' : product.name);
    _quantityControllor =
        TextEditingController(text: product == null ? '' : product.quantity);
    _descriptionControllor =
        TextEditingController(text: product == null ? '' : product.description);
  }

  late final TextEditingController _priceControllor;
  late final TextEditingController _nameControllor;
  late final TextEditingController _quantityControllor;
  late final TextEditingController _descriptionControllor;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  // File? path;
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<AddProductBloc, AddProductState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AddProductBloc>().add(AddImageEvent());
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: BlocBuilder<AddProductBloc, AddProductState>(
                          buildWhen: (previous, current) =>
                              current is AddImageState,
                          builder: (context, state) {
                            if (state is AddImageState) {
                              _imageUrl = state.imagestate.path;
                              return Image.file(
                                state.imagestate,
                                fit: BoxFit.cover,
                              );
                            } else {
                              if (_imageUrl.isNotEmpty) {
                                return Image.network(_imageUrl);
                              }
                              return Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey[500],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameControllor,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceControllor,
                  decoration: const InputDecoration(
                    labelText: 'Price (₹)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Select Category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Indoor',
                      child: Text('Indoor'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Outdoor',
                      child: Text('Outdoor'),
                    ),
                  ],
                  underline: Container(
                    width: 10,
                    height: 1,
                    color: Colors.black,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  value: dropdownValue,
                  onChanged: (String? newvalue) {
                    setState(
                      () {
                        dropdownValue = newvalue!;
                      },
                    );
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _quantityControllor,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionControllor,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Discription';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is ProductEditSuccessState) {
            context.read<AddProductBloc>().add(ProductFetchEvent());
            Navigator.pop(context);
          } else if (state is AddProductDataState) {
            context.read<AddProductBloc>().add(ProductFetchEvent());
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  // int parsedPrice =
                  //     int.tryParse(_priceControllor.text.trim()) ?? 0;
                  // int parsedquantity =
                  //     int.tryParse(_quantityControllor.text.trim()) ?? 0;
                  _form.currentState!.save();
                  final productModel = ProductClass(
                    description: _descriptionControllor.text.trim(),
                    category: dropdownValue,
                    price: _priceControllor.text.trim(),
                    name: _nameControllor.text.trim(),
                    quantity: _quantityControllor.text.trim(),
                    id: widget.product == null
                        ? uniqueFileName
                        : widget.product!.id,
                    searchName: _nameControllor.text.toLowerCase().trim(),
                  );
                  if (widget.product == null) {
                    context.read<AddProductBloc>().add(
                          FirebaseAddEvent(
                            imageFile: File(_imageUrl),
                            context: context,
                            product: productModel,
                          ),
                        );
                  } else {
                    // final image = path == null ? _imageUrl : path!.path;
                    context.read<AddProductBloc>().add(
                          ProductEditEvent(
                            imageFile: _imageUrl,
                            context: context,
                            product: productModel,
                          ),
                        );
                  }
                  // print('triggerd');
                  // if (!context.mounted) {
                  //   return;
                  // }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.all(16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: state is ProductEditLoadingState
                  ? const CircularProgressIndicator()
                  : const Text('Add Product'),
            ),
          );
        },
      ),
    );
  }
}
