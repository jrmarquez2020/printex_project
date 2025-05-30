import 'package:flutter/material.dart';

class HowToUseAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("How to Use the App")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Replace the AssetImage path once you upload the image
              Image.asset('assets/images/how_to_use.png', fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}
