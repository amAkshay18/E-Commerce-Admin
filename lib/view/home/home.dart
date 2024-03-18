import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/auth/auth.dart';
import 'package:leafloom_admin/view/earnings/earnings.dart';
import 'package:leafloom_admin/view/home/widget/home_card.dart';
import 'package:leafloom_admin/view/orders/screens/orders.dart';
import 'package:leafloom_admin/view/product/screen/all_products.dart';
import 'package:leafloom_admin/view/settings/screens/settings.dart';
import 'package:leafloom_admin/view/total_stocks.dart/total_stocks.dart';
import 'package:leafloom_admin/widget/common_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> _screens = [
    const ScreenAllProducts(),
    ScreenEarnings(),
    const ScreenStocks(),
    const OrdersScreen(),
    // const PaymentMethordsScreen(),
    // const UsersScreen(),
  ];
  final List<IconData> _screenIcons = [
    Icons.shopping_cart_outlined,
    Icons.money,
    Icons.shop,
    Icons.card_giftcard,
    // Icons.attach_money,
    // Icons.person
  ];
  final List<String> _screenName = [
    'Products',
    'Earnings',
    'Stocks',
    'Orders',
    // 'Payment Methords',
    // 'User Screen'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'LeafLoom-Admin',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenSettings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                firebase.signOut();
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                kHeight40,
                const SizedBox(
                  height: 40,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    const cardWidth = 200.0;
                    const cardHeight = 200.0;

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: cardWidth / cardHeight,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        return AdminCard(
                          icon: _screenIcons[index],
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          name: _screenName[index],
                          navigator: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => _screens[index],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const LinearGradient gcolor = LinearGradient(colors: [
  Color.fromARGB(255, 245, 126, 80),
  Color.fromARGB(255, 125, 238, 149),
], begin: Alignment.topLeft);
