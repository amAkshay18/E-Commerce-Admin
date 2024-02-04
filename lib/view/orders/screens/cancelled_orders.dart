import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/models/order_model.dart';
import 'package:leafloom_admin/view/orders/widget/order_card.dart';
import 'package:leafloom_admin/view/orders/widget/order_detiles.dart';

class CanceledOrders extends StatelessWidget {
  const CanceledOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Order')
            .where('status', isEqualTo: 'Cancelled') // Filter by status
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Shimmer loading state
            return ListView(
              children: List.generate(
                10,
                (index) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 150,
                    width: double.infinity,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            // No pending orders
            return const Center(
              child: Text('No Cancelled orders.'),
            );
          } else {
            List<OrderModel> orders = snapshot.data!.docs
                .map((doc) =>
                    OrderModel.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                OrderModel order = orders[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            order: order,
                          ),
                        ),
                      );
                    },
                    child: OrderCard(order: order),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
