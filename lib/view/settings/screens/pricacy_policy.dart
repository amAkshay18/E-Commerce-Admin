import 'package:flutter/material.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Privacy Policy'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '''
Privacy Policy for Admin LeafLoom
Last Updated: 25-11-2023

Admin LeafLoom we operates the Admin LeafLoom mobile application . This page informs you of our policies regarding the collection, use, and disclosure of Personal Information and data when you use our App.

By using the App, you agree to the collection and use of information in accordance with this policy.

Information We Collect:
Plant Information:
  - Plant name
  - Plant image
  - Plant description
  - Plant category (indoor or outdoor)

Order and Earnings Information:
  - Order details
  - Earnings and revenue information

Use of Information:
We use the collected information for various purposes, including:
  - Managing and displaying plant information in the App.
  - Managing and processing orders.
  - Tracking earnings and revenue.

Data Security:
  The security of your information is important to us, but remember that no method of transmission over the internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Information, we cannot guarantee its absolute security.

Sharing of Information:
We do not share Personal Information with third parties except as described in this privacy policy.

Changes to This Privacy Policy:
We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.
   
Contact Us:
If you have any questions about this Privacy Policy, please contact us at thisisakshayp18@gmail.com.
              ''',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
