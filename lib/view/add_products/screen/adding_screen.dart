import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leafloom_admin/bloc/product_bloc/add_product_bloc.dart';
import 'package:leafloom_admin/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();
  File? pickedImageFile;
  String dropdownValue = 'Indoor';
  final _priceControllor = TextEditingController();
  final _nameControllor = TextEditingController();
  final _quantityControllor = TextEditingController();
  final _discriptionControllor = TextEditingController();
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  late File? path;
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
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
                        BlocProvider.of<AddProductBloc>(context)
                            .add(AddImageEvent());
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: BlocBuilder<AddProductBloc, AddProductState>(
                          builder: (context, state) {
                            if (state is AddImageState) {
                              path = state.imagestate;
                              return Image.file(
                                state.imagestate,
                                fit: BoxFit.cover,
                              );
                            } else {
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
                  controller: _discriptionControllor,
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
                ElevatedButton(
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
                      // int parsedPrice =
                      //     int.tryParse(_priceControllor.text.trim()) ?? 0;
                      // int parsedquantity =
                      //     int.tryParse(_quantityControllor.text.trim()) ?? 0;
                      _form.currentState!.save();
                      final productModel = ProductClass(
                        description: _discriptionControllor.text.trim(),
                        category: dropdownValue,
                        price: _priceControllor.text.trim(),
                        name: _nameControllor.text.trim(),
                        quantity: _quantityControllor.text.trim(),
                        id: uniqueFileName,
                        searchName: _nameControllor.text.toLowerCase().trim(),
                      );

                      BlocProvider.of<AddProductBloc>(context).add(
                        FirebaseAddEvent(
                          imageFile: path!,
                          context: context,
                          product: productModel,
                        ),
                      );
                      // print('triggerd');
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).pop();
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
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
