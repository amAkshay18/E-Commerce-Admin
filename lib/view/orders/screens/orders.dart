import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/home/home.dart';
import 'package:leafloom_admin/view/orders/screens/all_orders.dart';
import 'package:leafloom_admin/view/orders/screens/cancelled_orders.dart';
import 'package:leafloom_admin/view/orders/screens/completed_orders.dart';
import 'package:leafloom_admin/view/orders/screens/pending_orders.dart';
import 'package:leafloom_admin/widget/common_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'All orders',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: gcolor),
          child: Column(
            children: [
              kHeight20,
              OrderCards(
                size: size,
                name: 'All orders',
                nav: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AllOrderScreen(),
                  ));
                },
              ),
              kHeight20,
              OrderCards(
                size: size,
                name: 'Completed Orders',
                nav: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CompletedOrders(),
                  ));
                },
              ),
              kHeight20,
              OrderCards(
                size: size,
                name: 'Pending Orders',
                nav: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PendingOrders(),
                  ));
                },
              ),
              kHeight20,
              OrderCards(
                size: size,
                name: 'Cancelled Orders',
                nav: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CanceledOrders(),
                  ));
                },
              )
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class OrderCards extends StatelessWidget {
  OrderCards({
    super.key,
    required this.size,
    required this.nav,
    required this.name,
  });
  final String name;
  final Size size;
  VoidCallback nav;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          nav();
        },
        child: Card(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            height: size.height / 7,
            width: double.infinity,
            child: Center(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
