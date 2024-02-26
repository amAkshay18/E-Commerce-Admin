import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/models/order_model.dart';
import '../../../widget/common_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height / 23,
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(order.address!.fullname!),
                    Text(
                      'Order ID: OD${order.orderId}',
                      // Text(order.address!.fullname!),

                      // 'Order ID: OD${order.orderId}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 106, 106, 106),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kHeight40,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Text(
                        ' ${order.productName} ',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '₹ ${order.totalPrice} ',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      Text(
                        'Category: ${order.category}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${order.status}',
                            style: TextStyle(
                              fontSize: 16,
                              color: order.status == 'Pending'
                                  ? Colors.orange
                                  : order.status == 'Shipped'
                                      ? Colors.amber
                                      : order.status == 'Delivered'
                                          ? Colors.red
                                          : Colors.green,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    color: const Color.fromARGB(255, 234, 233, 228),
                    width: size.width / 4,
                    height: size.height / 9,
                    child: Image.network(
                      '${order.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            kHeight20,
            Center(
              child: Column(
                children: [
                  const Text(
                    'Change product status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  BuildContext ctx = context;
                                  await FirebaseFirestore.instance
                                      .collection('Order')
                                      .doc(order.orderId)
                                      .update(
                                    {
                                      'status': 'Shipped',
                                    },
                                  );
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                ),
                              ),
                            ],
                            content: const Text(
                                'Are you sure you wanna change order status  to Shipped'),
                          );
                        },
                      );
                    },
                    child: const Text('Product Shipped'),
                  ),
                  kHeight20,
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  BuildContext ctx = context;
                                  await FirebaseFirestore.instance
                                      .collection('Order')
                                      .doc(order.orderId)
                                      .update(
                                    {
                                      'status': 'Delivered ',
                                    },
                                  );
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                ),
                              ),
                            ],
                            content: const Text(
                              'Are you sure you wanna change order status  to Shipped',
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Product Delivered',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle Cancel
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Return
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:leafloom_admin/models/order_model.dart';
// import 'package:leafloom_admin/models/address_model.dart';
// import '../../../widget/common_widget.dart';

// class OrderDetailsScreen extends StatelessWidget {
//   final OrderModel order;

//   const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: size.width,
//               height: size.height / 23,
//               decoration: BoxDecoration(
//                 border: Border.all(width: 0.1),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Order ID: OD${order.orderId}',
//                   style: const TextStyle(
//                     color: Color.fromARGB(255, 106, 106, 106),
//                   ),
//                 ),
//               ),
//             ),
//             kHeight40,
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         ' ${order.productName} ',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         '₹ ${order.totalPrice} ',
//                         style:
//                             const TextStyle(fontSize: 20, color: Colors.green),
//                       ),
//                       Text(
//                         'Category: ${order.category}',
//                         style:
//                             const TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           const Text(
//                             'Status: ',
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             '${order.status}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: order.status == 'Pending'
//                                   ? Colors.orange
//                                   : order.status == 'Shipped'
//                                       ? Colors.amber
//                                       : order.status == 'Delivered'
//                                           ? Colors.red
//                                           : Colors.green,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Address: ${order.address?.addressLine ?? ''}, ${order.address?.city ?? ''}, ${order.address?.state ?? ''}, ${order.address?.zipCode ?? ''}, ${order.address?.country ?? ''}',
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10.0),
//                   child: Container(
//                     color: const Color.fromARGB(255, 234, 233, 228),
//                     width: size.width / 4,
//                     height: size.height / 9,
//                     child: Image.network(
//                       '${order.imageUrl}',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             kHeight20,
//             Center(
//               child: Column(
//                 children: [
//                   const Text(
//                     'Change product status',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             actions: [
//                               TextButton(
//                                 onPressed: () async {
//                                   BuildContext ctx = context;
//                                   await FirebaseFirestore.instance
//                                       .collection('Order')
//                                       .doc(order.orderId)
//                                       .update(
//                                     {
//                                       'status': 'Shipped',
//                                     },
//                                   );
//                                   Navigator.of(ctx).pop();
//                                 },
//                                 child: const Text(
//                                   'OK',
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Text(
//                                   'Cancel',
//                                 ),
//                               ),
//                             ],
//                             content: const Text(
//                                 'Are you sure you wanna change order status to Shipped'),
//                           );
//                         },
//                       );
//                     },
//                     child: const Text('Product Shipped'),
//                   ),
//                   kHeight20,
//                   ElevatedButton(
//                     onPressed: () async {
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             actions: [
//                               TextButton(
//                                 onPressed: () async {
//                                   BuildContext ctx = context;
//                                   await FirebaseFirestore.instance
//                                       .collection('Order')
//                                       .doc(order.orderId)
//                                       .update(
//                                     {
//                                       'status': 'Delivered ',
//                                     },
//                                   );
//                                   Navigator.of(ctx).pop();
//                                 },
//                                 child: const Text(
//                                   'OK',
//                                   style: TextStyle(color: Colors.red),
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Text(
//                                   'Cancel',
//                                 ),
//                               ),
//                             ],
//                             content: const Text(
//                               'Are you sure you wanna change order status to Shipped',
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: const Text(
//                       'Product Delivered',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
