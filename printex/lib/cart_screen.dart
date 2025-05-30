import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:printex/payment_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Set<String> _selectedItemIds = {};
  bool _selectAll = false;

  void _toggleSelectAll(bool? value, List<DocumentSnapshot> cartItems) {
    setState(() {
      _selectAll = value ?? false;
      _selectedItemIds =
          _selectAll ? cartItems.map((doc) => doc.id).toSet() : {};
    });
  }

  void _toggleItemSelection(String id) {
    setState(() {
      if (_selectedItemIds.contains(id)) {
        _selectedItemIds.remove(id);
      } else {
        _selectedItemIds.add(id);
      }
      _selectAll = false; // reset selectAll if manual toggle
    });
  }

  void _proceedToPayment(List<DocumentSnapshot> cartItems) {
    if (_selectedItemIds.isEmpty) return;

    final selectedItems =
        cartItems.where((item) => _selectedItemIds.contains(item.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(selectedItems: selectedItems),
      ),
    );
  }

  Future<void> _deleteCartItem(String id) async {
    await FirebaseFirestore.instance.collection('cart').doc(id).delete();
  }

  Future<void> _confirmDelete(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Delete Item"),
            content: Text(
              "Are you sure you want to delete this item from the cart?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await _deleteCartItem(id);
    }
  }

  Future<bool> _onWillPop() async {
    // Allow system back button to work normally
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          automaticallyImplyLeading: false, 
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('cart').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final cartItems = snapshot.data?.docs ?? [];

            if (cartItems.isEmpty) {
              return Center(child: Text("Your Cart is Empty"));
            }

            return Column(
              children: [
                CheckboxListTile(
                  title: Text("Select All"),
                  value: _selectAll,
                  onChanged: (val) => _toggleSelectAll(val, cartItems),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (_, index) {
                      final item = cartItems[index];
                      return Dismissible(
                        key: Key(item.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            await _confirmDelete(item.id);
                            return false;
                          }
                          return false;
                        },
                        child: ListTile(
                          title: Text(item['productType'] ?? 'Item'),
                          subtitle: Text(
                            "Size: ${item['size']} - Quantity: ${item['quantity']}",
                          ),
                          trailing: Checkbox(
                            value: _selectedItemIds.contains(item.id),
                            onChanged: (_) => _toggleItemSelection(item.id),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 50),
                      backgroundColor: Color.fromRGBO(248, 199, 148, 1),
                    ),
                    onPressed: () => _proceedToPayment(cartItems),
                    child: Text("Pay", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
