import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot?> getUserData() async {
    if (user == null) return null;
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('users') // make sure your user data is stored here
              .doc(user!.uid)
              .get();
      return doc;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        user?.displayName ?? user?.email?.split('@')[0] ?? "Unknown";
    final email = user?.email ?? "No email";

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: FutureBuilder<DocumentSnapshot?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.data() as Map<String, dynamic>?;

          final address = data?['address'] ?? 'Not provided';
          final phoneNumber = data?['phone'] ?? 'Not provided';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Info",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Username"),
                  subtitle: Text(displayName),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text("Email"),
                  subtitle: Text(email),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Address"),
                  subtitle: Text(address),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Phone Number"),
                  subtitle: Text(phoneNumber),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
