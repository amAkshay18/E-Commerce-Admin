// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leafloom_admin/bloc/product_bloc/add_product_bloc.dart';
// import 'package:leafloom_admin/data/product_functions/product_adding_function.dart';
// import 'package:leafloom_admin/widget/common_widget.dart';

// // ignore: must_be_immutable
// class ImageEditScreen extends StatelessWidget {
//   ImageEditScreen({super.key, required this.id});
//   File? pickedImageFile;
//   final String id;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(backgroundColor: Colors.black),
//         body: Column(
//           children: [
//             kHeight20,
//             Center(
//               child: Container(
//                 height: MediaQuery.sizeOf(context).height * 0.3,
//                 width: MediaQuery.sizeOf(context).width * 0.9,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     BlocProvider.of<AddProductBloc>(context).add(
//                       AddImageEvent(),
//                     );
//                   },
//                   child: BlocBuilder<AddProductBloc, AddProductState>(
//                     builder: (context, state) {
//                       if (state is AddImageState) {
//                         pickedImageFile = state.imagestate;
//                         return Image.file(
//                           state.imagestate,
//                           fit: BoxFit.cover,
//                         );
//                       } else {
//                         return Center(
//                           child: Icon(
//                             Icons.add_a_photo,
//                             size: 40,
//                             color: Colors.grey[500],
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             kHeight20,
//             ElevatedButton(
//               onPressed: () async {
//                 final imgUrl =
//                     await uploadImageToFirebase(imageFile: pickedImageFile!);
//                 await FirebaseFirestore.instance
//                     .collection('Products')
//                     .doc(id)
//                     .update(
//                   {
//                     'imageUrl': imgUrl,
//                   },
//                 );
//                 // ignore: use_build_context_synchronously
//                 Navigator.of(context).pop();
//               },
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
//                 minimumSize: MaterialStateProperty.all<Size>(
//                   const Size(350, 60),
//                 ),
//               ),
//               child: const Text(
//                 'Upload new image',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /*================name====================== */
// class ProductNameEditScreen extends StatelessWidget {
//   ProductNameEditScreen({super.key, required this.id});
//   final String id;
//   final _nameControllor = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: CommonTextFields(
//                 inputType: TextInputType.name,
//                 labelText: 'Productname',
//                 validator: 'Please Enter Product Name',
//                 nameControllor: _nameControllor),
//           ),
//           kHeight20,
//           CommonButtonTwo(
//             change: _nameControllor.text,
//             id: id,
//             name: 'Update new name',
//             voidCallback: () async {
//               await FirebaseFirestore.instance
//                   .collection('Products')
//                   .doc(id)
//                   .update(
//                 {
//                   'name': _nameControllor.text.trim(),
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// /*=================================================Price============================================== */
// class PriceEditScreen extends StatelessWidget {
//   PriceEditScreen({super.key, required this.id});
//   final _priceControllor = TextEditingController();
//   final String id;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CommonTextFields(
//                 inputType: TextInputType.number,
//                 labelText: 'Price',
//                 validator: 'Please Enter Product Price',
//                 nameControllor: _priceControllor),
//           ),
//           CommonButtonTwo(
//               name: 'Update new price',
//               voidCallback: () async {
//                 await FirebaseFirestore.instance
//                     .collection('Products')
//                     .doc(id)
//                     .update(
//                   {
//                     'price': _priceControllor.text.trim(),
//                   },
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }

// /*===========================================Quantity======================================== */
// class QuantityEditScreen extends StatelessWidget {
//   QuantityEditScreen({super.key, required this.id});
//   final _quantityControllor = TextEditingController();
//   final String id;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CommonTextFields(
//                 inputType: TextInputType.number,
//                 labelText: 'Quantity',
//                 validator: 'Please Enter Product Quantity',
//                 nameControllor: _quantityControllor),
//           ),
//           CommonButtonTwo(
//             name: 'Update new quantity',
//             voidCallback: () async {
//               await FirebaseFirestore.instance
//                   .collection('Products')
//                   .doc(id)
//                   .update(
//                 {
//                   'quantity': _quantityControllor.text.trim(),
//                 },
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// /*====================================================Category========================================== */
// enum PlantsCategory { indoor, outdoor }

// class CategoryEditScreen extends StatefulWidget {
//   const CategoryEditScreen({super.key, required this.id});
//   final String id;

//   @override
//   State<CategoryEditScreen> createState() => _CategoryEditScreenState();
// }

// class _CategoryEditScreenState extends State<CategoryEditScreen> {
//   PlantsCategory? _character = PlantsCategory.indoor;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Category'),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             title: const Text('Indoor'),
//             leading: Radio<PlantsCategory>(
//               value: PlantsCategory.indoor,
//               groupValue: _character,
//               onChanged: (PlantsCategory? value) {
//                 setState(
//                   () {
//                     _character = value;
//                   },
//                 );
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Outdoor'),
//             leading: Radio<PlantsCategory>(
//               value: PlantsCategory.outdoor,
//               groupValue: _character,
//               onChanged: (PlantsCategory? value) {
//                 setState(
//                   () {
//                     _character = value;
//                   },
//                 );
//               },
//             ),
//           ),
//           CommonButtonTwo(
//             name: 'Save',
//             voidCallback: () async {
//               if (_character == PlantsCategory.indoor) {
//                 await FirebaseFirestore.instance
//                     .collection('Products')
//                     .doc(widget.id)
//                     .update({
//                   'category': 'Indoor',
//                 });
//               } else {
//                 await FirebaseFirestore.instance
//                     .collection('Products')
//                     .doc(widget.id)
//                     .update(
//                   {
//                     'category': 'Outdoor',
//                   },
//                 );
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// /*============================================Discription============================================ */
// class DescriptionEditScreen extends StatelessWidget {
//   DescriptionEditScreen({super.key, required this.id});
//   final _discriptionControllor = TextEditingController();
//   final String id;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: CommonTextFields(
//               inputType: TextInputType.text,
//               labelText: 'Description',
//               validator: 'Please Enter Product discription',
//               nameControllor: _discriptionControllor,
//             ),
//           ),
//           CommonButtonTwo(
//               name: 'Update new Discription',
//               voidCallback: () async {
//                 await FirebaseFirestore.instance
//                     .collection('Products')
//                     .doc(id)
//                     .update(
//                   {
//                     'description': _discriptionControllor.text.trim(),
//                   },
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
