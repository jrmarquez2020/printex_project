import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final List<DocumentSnapshot> selectedItems;

  PaymentScreen({required this.selectedItems});

  Future<void> _processPayment(BuildContext context, String method) async {
    final paymentData = {
      'method': method,
      'items': selectedItems.map((doc) => doc.data()).toList(),
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'On Delivery',
    };

    await FirebaseFirestore.instance.collection('payments').add(paymentData);

    for (var doc in selectedItems) {
      await FirebaseFirestore.instance.collection('cart').doc(doc.id).delete();
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Payment Successful")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Payment Method")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(248, 199, 148, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () => _processPayment(context, "COD"),
                child: Text("COD", style: TextStyle(color: Colors.black)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(248, 199, 148, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () => _processPayment(context, "GCash"),
                child: Text(
                  "Pay with GCash",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
