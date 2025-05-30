import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String tagline;
  final List<String> bullets;
  final String description;
  final VoidCallback onSeeSizes;
  final VoidCallback onChooseImage;

  const ProductDetailScreen({
    required this.imageAsset,
    required this.title,
    required this.tagline,
    required this.bullets,
    required this.description,
    required this.onSeeSizes,
    required this.onChooseImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  child: Image.asset(imageAsset, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              color: Color(0xFFF8C794),
              padding: EdgeInsets.all(16),
              width: double.infinity,
              height: screenHeight * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    tagline,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onSeeSizes,
                      child: Text(
                        "See Sizes >",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    bullets
                        .map(
                          (b) => ListTile(
                            leading: Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.black87,
                            ),
                            title: Text(b, style: TextStyle(fontSize: 14)),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                          ),
                        )
                        .toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: onChooseImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(248, 199, 148, 1),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Choose Image",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
