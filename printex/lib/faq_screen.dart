import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "What is Printex?",
      "answer":
          "Printex is a mobile app that allows users to upload photos and place print orders quickly and easily. We offer different sizes and delivery options.",
    },
    {
      "question": "How do I place an order?",
      "answer":
          "Simply choose an image, select the print size and quantity, then add it to your cart. Once done, proceed to checkout and confirm your order.",
    },
    {
      "question": "What payment methods are supported?",
      "answer":
          "We currently support Cash on Delivery (COD) and GCash as payment methods.",
    },
    {
      "question": "How long does delivery take?",
      "answer":
          "Deliveries typically take 3–5 business days depending on your location.",
    },
    {
      "question": "Can I track my order?",
      "answer":
          "Yes. You can view the status of your order on the Orders tab. The default status is 'On Delivery' once confirmed.",
    },
    {
      "question": "Is there customer support?",
      "answer":
          "Yes! You can chat with our virtual assistant under the 'Customer Service' tab for help anytime.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FAQs")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(
              faq["question"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(faq["answer"]!),
              ),
            ],
          );
        },
      ),
    );
  }
}
