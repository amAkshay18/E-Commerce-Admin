// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:leafloom_admin/view/product/screen/editing_pages.dart';
// import 'package:leafloom_admin/widget/common_widget.dart';

// class ScreenEditing extends StatefulWidget {
//   const ScreenEditing({super.key, required this.id});
//   final String id;
//   @override
//   State<ScreenEditing> createState() => _ScreenEditingState();
// }

// class _ScreenEditingState extends State<ScreenEditing> {
//   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

//   late File? path;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Image',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ImageEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Product Name',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           ProductNameEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Price',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => PriceEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Quantity',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => QuantityEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Category',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => CategoryEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//           kHeight20,
//           Padding(
//             padding: const EdgeInsets.all(9.0),
//             child: CommonButton(
//                 name: 'Discription',
//                 voidCallback: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           DescriptionEditScreen(id: widget.id),
//                     ),
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
