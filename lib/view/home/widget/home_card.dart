import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/home/home.dart';

// ignore: must_be_immutable
class AdminCard extends StatelessWidget {
  AdminCard(
      {super.key,
      required this.cardWidth,
      required this.cardHeight,
      required this.navigator,
      required this.name,
      required this.icon});
  VoidCallback navigator;
  final double cardWidth;
  final double cardHeight;
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigator,
      child: Card(
        elevation: 6,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            gradient: gcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 60,
                ),
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
