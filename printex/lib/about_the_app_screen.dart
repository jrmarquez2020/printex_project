import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About the App")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/about.png', // Replace with your image path
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/about1.png', // Replace with your image path
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
