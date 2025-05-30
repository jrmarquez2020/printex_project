import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'instax_screen.dart';
import 'photo_printed_screen.dart';
import 'board_based_screen.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';
import 'customer_service_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MainContent(),
    CartScreen(),
    NotificationScreen(),
    CustomerServiceScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFF8C794), // Updated highlight color
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Help"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Printex",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false, // Removes back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            buildCard(
              context,
              title: "Instax Based",
              description: "Print your desired photos in an Instax form.",
              imageAsset: 'assets/images/instax.png',
              color: Colors.pink,
              screen: InstaxScreen(),
            ),
            buildCard(
              context,
              title: "Photo Printed",
              description: "Print your desired photo in any size you like.",
              imageAsset: 'assets/images/photo_printed.png',
              color: Colors.blue,
              screen: PhotoPrintedScreen(),
            ),
            buildCard(
              context,
              title: "Board Based",
              description: "Make your memories display however you like.",
              imageAsset: 'assets/images/board_based.png',
              color: Colors.green,
              screen: BoardBasedScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required String title,
    required String description,
    required String imageAsset,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          ),
      child: Card(
        color: Color(0xFFF8C794), // Card background
        margin: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageAsset,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Updated text color
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ), // Updated text color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
