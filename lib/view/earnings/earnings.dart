import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom_admin/view/home/home.dart';
import 'package:leafloom_admin/widget/common_widget.dart';

// ignore: must_be_immutable
class ScreenEarnings extends StatelessWidget {
  ScreenEarnings({Key? key}) : super(key: key);
  CollectionReference earningsreference =
      FirebaseFirestore.instance.collection('Order');
  // EarningsType _change = EarningsType.last30days;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Earnings',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: earningsreference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text('Error:----------- ${snapshot.error}');
          }
          List<QueryDocumentSnapshot<Object?>> data = [];
          if (snapshot.data == null) {
            return const Center(
              child: Text('No orders'),
            );
          }
          data = snapshot.data!.docs;
          double totalSum = data.fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element['totalPrice'].toString()),
          );
          if (snapshot.data!.docs.isEmpty || data.isEmpty) {
            return const Center(
              child: Text('Empty'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                kHeight30,
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: size.height / 7,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Total: ₹${totalSum.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total product you have sold ${data.length}',
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Text(
                  'All Products',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, a) {
                    return kHeight20;
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: gcolor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          leading: Container(
                            width: 70.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data[index]['imageUrl']),
                              ),
                            ),
                          ),
                          title: Text(
                            data[index]['productName'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8.0),
                              Text('Date: ${data[index]['date']}'),
                              Text('Price: ₹${data[index]['totalPrice']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                kHeight40,
                kHeight40
              ],
            ),
          );
        },
      ),
    );
  }
}
