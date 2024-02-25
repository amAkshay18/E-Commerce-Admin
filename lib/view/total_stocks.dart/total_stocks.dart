import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScreenStocks extends StatelessWidget {
  const ScreenStocks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Available',
                icon: Icon(Icons.event_available),
              ),
              Tab(
                text: 'Out of Stock',
                icon: Icon(Icons.shopping_bag),
              ),
            ],
          ),
          title: const Text('Stocks'),
        ),
        body: const TabBarView(
          children: [
            StockList(filter: 'available'),
            StockList(filter: 'stockOut'),
          ],
        ),
      ),
    );
  }
}

class StockList extends StatelessWidget {
  final String filter;

  const StockList({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        // Filter the documents based on the quantity string and the provided filter
        List<DocumentSnapshot> filteredDocuments = documents.where((doc) {
          String quantity = doc['quantity'].toString();
          if (filter == 'available') {
            return quantity != '0';
          } else if (filter == 'stockOut') {
            return quantity == '0';
          }
          return false;
        }).toList();

        return ListView.builder(
          itemCount: filteredDocuments.length,
          itemBuilder: (context, index) {
            return StockItem(doc: filteredDocuments[index]);
          },
        );
      },
    );
  }
}

class StockItem extends StatelessWidget {
  final DocumentSnapshot doc;

  const StockItem({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 150, // Adjust the height as needed
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    doc['imageUrl'], // Change this to your field name
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              // Product Details
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc['name'], // Change this to your field name
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Price: ₹${doc['price']}', // Change this to your field name
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Quantity: '),
                        Text(
                          doc['quantity'].toString(),
                        ), // Change this to your field name
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
