import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        automaticallyImplyLeading: false,
      ),

      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('payments')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final docs = snapshot.data.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, index) {
              final data = docs[index].data();
              final items = List<Map<String, dynamic>>.from(
                data['items'] ?? [],
              );

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Paid - ${data['method']}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Status: On Delivery",
                        style: TextStyle(color: Colors.green),
                      ),
                      Divider(height: 20),
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "- ${item['productType']} | Size: ${item['size']} | Qty: ${item['quantity']}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
