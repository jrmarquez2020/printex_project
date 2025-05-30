import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final String _privacyText = '''
At Printex, your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information.

1. **Information We Collect**
We collect personal information such as your name, email address, delivery address, and phone number. We also store images you upload for printing.

2. **How We Use Your Information**
Your information is used to:
- Process and deliver print orders
- Communicate with you about your orders
- Provide customer support
- Improve our services

3. **Data Storage**
Your data is securely stored in Firebase services. We take appropriate measures to ensure the security of your personal data.

4. **Sharing of Information**
We do not sell or rent your personal information. Information may be shared with delivery partners only for fulfillment purposes.

5. **User Control**
You can access, update, or delete your personal information by contacting customer support or through your account settings.

6. **Changes to This Policy**
We may update this policy from time to time. You will be notified of significant changes within the app.

7. **Contact Us**
For questions about this Privacy Policy, please contact our support team in the Customer Service section of the app.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            _privacyText,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
