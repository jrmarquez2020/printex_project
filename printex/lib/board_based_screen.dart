import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'product_detail_screen.dart';
import 'see_sizes_screen.dart';

class BoardBasedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductDetailScreen(
      imageAsset: 'assets/images/board_screen.jpg',
      title: 'Board Based',
      tagline: 'Some moments are too precious to stay digital',
      bullets: [
        'From 8x8 to 20x30 sizes',
        'Strong, durable material',
        'Perfect for decor and gallery walls',
        'Modern and sleek finishes',
        'High contrast and vivid output',
      ],
      description:
          'Frame your memories in the perfect size – from compact 8x8 to grand 20x30. Whether for home decor, gallery walls, or personal collections, each frame brings out the beauty of your cherished moments with a stylish and elegant touch.',
      onSeeSizes: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) =>
                    SeeSizesScreen(imageAsset: 'assets/images/board_based.jpg'),
          ),
        );
      },
      onChooseImage: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => UploadModal(productType: 'Board Based'),
        );
      },
    );
  }
}

class UploadModal extends StatefulWidget {
  final String productType;

  UploadModal({required this.productType});

  @override
  _UploadModalState createState() => _UploadModalState();
}

class _UploadModalState extends State<UploadModal> {
  File? _selectedImage;
  String? _size;
  int _quantity = 1;
  bool _uploading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _confirmOrder() async {
    if (_selectedImage == null || _size == null) return;
    setState(() => _uploading = true);

    final imageUrl = await uploadImageToCloudinary(_selectedImage!);
    if (imageUrl == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image upload failed")));
      setState(() => _uploading = false);
      return;
    }

    await FirebaseFirestore.instance.collection('cart').add({
      'imageUrl': imageUrl,
      'size': _size,
      'quantity': _quantity,
      'productType': widget.productType,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Added to cart")));
  }

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    final cloudName = 'dhjepfsna';
    final uploadPreset = 'mdvaclce';

    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = uploadPreset
          ..files.add(
            await http.MultipartFile.fromPath('file', imageFile.path),
          );

    final response = await request.send();

    if (response.statusCode == 200) {
      final respData = await response.stream.bytesToString();
      final jsonData = json.decode(respData);
      return jsonData['secure_url'];
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(248, 199, 148, 1),
            ),
            onPressed: _pickImage,
            child: Text("Choose Image", style: TextStyle(color: Colors.black)),
          ),
          if (_selectedImage != null) Image.file(_selectedImage!, height: 100),
          DropdownButton<String>(
            hint: Text("Select Size"),
            value: _size,
            items:
                [
                      '8x8',
                      '10x8',
                      '12x8',
                      '12x12',
                      '12x14',
                      '15x13',
                      '15x20',
                      '20x20',
                      '18x25',
                      '1732',
                      '2024',
                      '20x30',
                    ]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
            onChanged: (val) => setState(() => _size = val),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity"),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
              ),
              Text('$_quantity'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() => _quantity++);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          _uploading
              ? CircularProgressIndicator()
              : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(248, 199, 148, 1),
                ),
                onPressed: _confirmOrder,
                child: Text(
                  "Confirm Order",
                  style: TextStyle(color: Colors.black),
                ),
              ),
        ],
      ),
    );
  }
}
