import 'package:flutter/material.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terms and Conditions'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '''
              1. Acceptance of Terms

              By using the App, you agree to comply with and be bound by these Terms. If you do not agree to these Terms, please do not use the App.

              2. Use of the App

              You agree to use the App for its intended purpose, which includes managing plant products, processing orders, and viewing earnings related to plant sales.

              3. Plant Information

              Admin Gardenia provides plant information for management purposes. While we strive for accuracy, we do not guarantee the completeness, accuracy, or reliability of plant information displayed in the App.

              4. Orders and Earnings

              When processing orders and viewing earnings, you agree to provide accurate and truthful information. Admin Gardenia is not responsible for any discrepancies or errors in orders or earnings that result from inaccurate information.

              5. User Account

              To use certain features of the App, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.

              6. Changes to the App

              We reserve the right to modify, suspend, or discontinue the App, or any part of it, at any time without notice. We will not be liable to you or any third party for any modification, suspension, or discontinuance of the App.

              7. Intellectual Property

              The App and its original content, features, and functionality are owned by Admin Gardenia and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.

              8. Limitation of Liability

              In no event shall Admin Gardenia, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.

              9. Governing Law

              These Terms shall be governed by and construed in accordance with the laws of India, without regard to its conflict of law provisions.

              10. Changes to Terms

              We may update our Terms from time to time. We will notify you of any changes by posting the new Terms on this page.
              
              Contact Us
              
              If you have any questions about this Privacy Policy, please contact us at ansertp47@gmail.com 
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
          child: const Text('Close'),
        ),
      ],
    );
  }
}
