import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/models/order_model.dart';
import 'package:leafloom_admin/view/home/home.dart';
import 'package:leafloom_admin/view/orders/widget/order_card.dart';
import 'package:leafloom_admin/view/orders/widget/order_detiles.dart';

class CompletedOrders extends StatelessWidget {
  const CompletedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Completed Orders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Order')
            .where('status', isEqualTo: 'Delivered')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
              child: Text('No  orders.'),
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

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.size,
    required this.nav,
  });

  final Size size;
  final VoidCallback nav;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          nav();
        },
        child: Card(
          elevation: 9,
          child: Container(
            height: size.height / 7,
            width: double.infinity,
            decoration: const BoxDecoration(gradient: gcolor),
            child: const Center(
              child: ListTile(
                title: Text(
                  'customer@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Order Completed'),
                trailing: Text('View'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
