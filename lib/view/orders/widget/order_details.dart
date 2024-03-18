import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/models/order_model.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
              ),
              child: Text(
                'Order ID: OD${order.orderId}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.address!.fullname!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Address: ${order.address!.house}, ${order.address!.area}, ${order.address!.city}, ${order.address!.state}, ${order.address!.pincode}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Phone: ${order.address!.phone}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName!,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        '₹ ${order.totalPrice}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Category: ${order.category}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            '${order.status}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: _getStatusColor(order.status!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: size.width / 4,
                  height: size.height / 9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 234, 233, 228),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      '${order.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Center(
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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _showConfirmationDialog(context, 'Shipped'),
            child: const Text('Product Shipped'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _showConfirmationDialog(context, 'Delivered'),
            child: const Text('Product Delivered'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content:
              Text('Are you sure you want to change order status to $status?'),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Order')
                    .doc(order.orderId)
                    .update({'status': status});
                Navigator.of(context).pop();
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
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Shipped':
        return Colors.amber;
      case 'Delivered':
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:leafloom_admin/models/order_model.dart';
// import '../../../widget/common_widget.dart';

// class OrderDetailsScreen extends StatelessWidget {
//   final OrderModel order;

//   const OrderDetailsScreen({super.key, required this.order});

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
//                 child: Row(
//                   children: [
//                     // Text(order.address!.fullname!),
//                     Text(
//                       'Order ID: OD${order.orderId}',
//                       // Text(order.address!.fullname!),

//                       // 'Order ID: OD${order.orderId}',
//                       style: const TextStyle(
//                         color: Color.fromARGB(255, 106, 106, 106),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             kHeight40,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 90, top: 9),
//                   child: Text(
//                     order.address!.fullname!,
//                     style: const TextStyle(
//                         fontSize: 17, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.house!,

//                     // 'Address: ${data[0]['house']}, ${data[0]['area']}, ${data[0]['city']}, ${data[0]['state']}, ${data[0]['pincode']}, ',
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     // maxLines: 4,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.area!,
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     maxLines: 4,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.city!,
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     maxLines: 4,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.state!,
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     maxLines: 4,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.pincode!,
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     maxLines: 4,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
//                   child: Text(
//                     order.address!.phone!,
//                     style: const TextStyle(
//                       fontSize: 17,
//                     ),
//                     maxLines: 4,
//                   ),
//                 ),
//               ],
//             ),
//             kHeight40,
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Column(
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
//                                   // ignore: use_build_context_synchronously
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
//                                 'Are you sure you wanna change order status  to Shipped'),
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
//                                   // ignore: use_build_context_synchronously
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
//                               'Are you sure you wanna change order status  to Shipped',
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

//   // ignore: unused_element
//   Widget _buildOrderActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             // Handle Cancel
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             // Handle Return
//           },
//           child: const Text('Return'),
//         ),
//       ],
//     );
//   }
// }
